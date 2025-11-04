import { Controller } from "@hotwired/stimulus";
import * as THREE from "three";

export default class extends Controller {
  static targets = [
    "classDisplay",
    "nameDisplay",
    "imageDisplay",
    "raceDisplay",
    "tokenInput",
    "viewport",
  ];

  connect() {
    this.#initScene();
    this.#updateBackgroundFrom(this.classDisplayTarget?.textContent);
    this.#applyRaceAccent(this.raceDisplayTarget?.textContent);
  }

  disconnect() {
    this.#teardownScene();
  }

  updateClass(event) {
    const value = event.target.value;
    if (this.hasClassDisplayTarget) {
      this.classDisplayTarget.textContent = value;
    }

    this.#updateBackgroundFrom(value);
    this.#updatePrimaryColor(value);
    this.#updateClassLoadout(value);
  }

  updateName(event) {
    if (this.hasNameDisplayTarget) {
      this.nameDisplayTarget.textContent = event.target.value || "Unnamed Hero";
    }
  }

  updateRace(event) {
    if (this.hasRaceDisplayTarget) {
      this.raceDisplayTarget.textContent = event.target.value;
    }

    this.#applyRaceAccent(event.target.value);
    this.#updateRaceTraits(event.target.value);
  }

  uploadToken(event) {
    const input = event.target;
    if (!input.files || input.files.length === 0) return;

    const [file] = input.files;
    this.#previewFile(file);

    const form = input.closest("form");
    form?.requestSubmit();
  }

  #initScene() {
    if (!this.hasViewportTarget || this.renderer) return;

    this.scene = new THREE.Scene();
    this.scene.fog = new THREE.Fog(0x0f172a, 10, 40);

    this.camera = new THREE.PerspectiveCamera(35, this.#aspectRatio, 0.1, 100);
    this.camera.position.set(0, 1.75, 6);

    this.renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    this.renderer.setPixelRatio(window.devicePixelRatio);
    this.renderer.shadowMap.enabled = true;
    this.#resize();

    this.viewportTarget.innerHTML = "";
    this.viewportTarget.appendChild(this.renderer.domElement);

    const hemisphereLight = new THREE.HemisphereLight(0xffffff, 0x2d1b10, 0.65);
    this.scene.add(hemisphereLight);

    const keyLight = new THREE.DirectionalLight(0xffffff, 0.75);
    keyLight.position.set(3, 6, 6);
    keyLight.castShadow = true;
    this.scene.add(keyLight);

    const rimLight = new THREE.DirectionalLight(0x9d174d, 0.45);
    rimLight.position.set(-6, 5, -2);
    this.scene.add(rimLight);

    const ambient = new THREE.AmbientLight(0xffffff, 0.2);
    this.scene.add(ambient);

    const accentColor = this.#accentColorFor(this.classDisplayTarget?.textContent);

    this.primaryMaterial = new THREE.MeshStandardMaterial({
      color: accentColor,
      metalness: 0.35,
      roughness: 0.45,
    });
    this.highlightMaterial = new THREE.MeshStandardMaterial({
      color: accentColor,
      emissive: new THREE.Color(accentColor),
      emissiveIntensity: 0.25,
      metalness: 0.55,
      roughness: 0.3,
    });
    this.secondaryMaterial = new THREE.MeshStandardMaterial({
      color: 0x0f172a,
      metalness: 0.25,
      roughness: 0.6,
    });
    this.armorMaterial = new THREE.MeshStandardMaterial({
      color: 0x111827,
      metalness: 0.7,
      roughness: 0.35,
    });
    this.clothMaterial = new THREE.MeshStandardMaterial({
      color: 0x1f2937,
      metalness: 0.2,
      roughness: 0.85,
    });
    this.leatherMaterial = new THREE.MeshStandardMaterial({
      color: 0x78350f,
      metalness: 0.15,
      roughness: 0.85,
    });
    this.trimMaterial = new THREE.MeshStandardMaterial({
      color: 0xf8fafc,
      metalness: 0.95,
      roughness: 0.2,
    });
    this.skinMaterial = new THREE.MeshStandardMaterial({ color: 0xffd8b1, roughness: 1 });
    this.eyeMaterial = new THREE.MeshStandardMaterial({
      color: 0xffffff,
      emissive: new THREE.Color(accentColor),
      emissiveIntensity: 0.1,
    });
    this.runeMaterial = new THREE.MeshBasicMaterial({
      color: this.#raceColorFor(this.raceDisplayTarget?.textContent),
      transparent: true,
      opacity: 0.5,
    });

    this.accentMaterials = new Set([this.primaryMaterial, this.highlightMaterial, this.eyeMaterial]);

    this.#buildCharacter();
    this.#createEnvironment();

    this.isDragging = false;
    this.lastDragDelta = 0;
    this.rotationVelocity = 0.0035;

    this.boundAnimate = this.#animate.bind(this);
    this.boundPointerDown = this.#handlePointerDown.bind(this);
    this.boundPointerMove = this.#handlePointerMove.bind(this);
    this.boundPointerUp = this.#handlePointerUp.bind(this);

    const canvas = this.renderer.domElement;
    canvas.style.width = "100%";
    canvas.style.height = "100%";
    canvas.addEventListener("pointerdown", this.boundPointerDown);
    window.addEventListener("pointermove", this.boundPointerMove);
    window.addEventListener("pointerup", this.boundPointerUp);

    if (typeof ResizeObserver === "function") {
      this.resizeObserver = new ResizeObserver(() => this.#resize());
      this.resizeObserver.observe(this.viewportTarget);
    }

    this.boundAnimate();
  }

  #teardownScene() {
    this.resizeObserver?.disconnect();
    this.resizeObserver = null;

    if (this.renderer) {
      this.renderer.domElement.removeEventListener("pointerdown", this.boundPointerDown);
      window.removeEventListener("pointermove", this.boundPointerMove);
      window.removeEventListener("pointerup", this.boundPointerUp);
      cancelAnimationFrame(this.animationFrame);

      this.scene.traverse((object) => {
        if (!object.isMesh) return;
        object.geometry?.dispose();
        if (Array.isArray(object.material)) {
          object.material.forEach((material) => material?.dispose?.());
        } else {
          object.material?.dispose?.();
        }
      });

      this.renderer.dispose();
      this.renderer.forceContextLoss?.();
      this.renderer = null;
    }

    this.scene = null;
    this.camera = null;
    this.characterGroup = null;
    this.runeCircle = null;
    this.capeMesh = null;
    this.weaponGroup = null;
    this.offhandGroup = null;
    this.rightHandGroup = null;
    this.leftHandGroup = null;
    this.faceAccessoryGroup = null;
    this.head = null;
    this.quiver = null;
    this.accentMaterials = null;
    this.highlightMaterial = null;
    this.primaryMaterial = null;
    this.secondaryMaterial = null;
    this.armorMaterial = null;
    this.clothMaterial = null;
    this.leatherMaterial = null;
    this.trimMaterial = null;
    this.eyeMaterial = null;
    this.runeMaterial = null;
    this.groundGlow = null;
  }

  #buildCharacter() {
    this.characterGroup = new THREE.Group();
    this.characterGroup.position.y = 0.15;

    const baseMaterial = new THREE.MeshStandardMaterial({
      color: 0x1f2937,
      roughness: 0.9,
      metalness: 0.05,
    });

    const pedestal = new THREE.Mesh(new THREE.CylinderGeometry(1.8, 2.1, 0.35, 48), baseMaterial);
    pedestal.receiveShadow = true;
    pedestal.position.y = -1.45;
    this.characterGroup.add(pedestal);

    const lowerRobe = new THREE.Mesh(new THREE.CapsuleGeometry(0.75, 1.4, 18, 32), this.clothMaterial);
    lowerRobe.castShadow = true;
    lowerRobe.position.y = -0.4;
    this.characterGroup.add(lowerRobe);

    const legOffset = 0.42;
    const createLeg = (side = 1) => {
      const legGroup = new THREE.Group();
      const upperLeg = new THREE.Mesh(new THREE.CylinderGeometry(0.28, 0.34, 1.1, 16), this.clothMaterial);
      upperLeg.castShadow = true;
      upperLeg.position.y = -0.2;
      legGroup.add(upperLeg);

      const knee = new THREE.Mesh(new THREE.SphereGeometry(0.28, 16, 16), this.armorMaterial);
      knee.position.y = -0.7;
      legGroup.add(knee);

      const boot = new THREE.Mesh(new THREE.BoxGeometry(0.45, 0.34, 0.9), this.leatherMaterial);
      boot.castShadow = true;
      boot.position.set(0, -1.05, 0.25);
      legGroup.add(boot);

      const bootTrim = new THREE.Mesh(new THREE.TorusGeometry(0.26, 0.06, 12, 24), this.primaryMaterial);
      bootTrim.rotation.x = Math.PI / 2;
      bootTrim.position.y = -0.85;
      legGroup.add(bootTrim);
      this.#registerAccentMaterial(bootTrim.material);

      legGroup.position.set(legOffset * side, -0.8, 0);
      legGroup.rotation.x = 0.05 * side;
      this.characterGroup.add(legGroup);
    };

    createLeg(-1);
    createLeg(1);

    const torso = new THREE.Mesh(new THREE.CapsuleGeometry(0.75, 1.2, 18, 32), this.clothMaterial);
    torso.castShadow = true;
    torso.position.y = 0.45;
    this.characterGroup.add(torso);

    const chestPlate = new THREE.Mesh(new THREE.BoxGeometry(1.2, 1.25, 0.75), this.armorMaterial);
    chestPlate.castShadow = true;
    chestPlate.position.y = 0.9;
    this.characterGroup.add(chestPlate);

    const chestTrim = new THREE.Mesh(new THREE.TorusGeometry(0.48, 0.08, 16, 32), this.primaryMaterial);
    chestTrim.rotation.x = Math.PI / 2;
    chestTrim.position.set(0, 0.75, 0.34);
    this.characterGroup.add(chestTrim);
    this.#registerAccentMaterial(chestTrim.material);

    const emblem = new THREE.Mesh(new THREE.IcosahedronGeometry(0.22, 0), this.highlightMaterial);
    emblem.position.set(0, 0.95, 0.42);
    this.characterGroup.add(emblem);
    this.#registerAccentMaterial(emblem.material);

    const sash = new THREE.Mesh(new THREE.TorusKnotGeometry(0.45, 0.08, 64, 8, 2, 3), this.secondaryMaterial);
    sash.rotation.z = Math.PI / 2;
    sash.position.set(0, -0.05, 0.15);
    this.characterGroup.add(sash);

    const belt = new THREE.Mesh(new THREE.TorusGeometry(0.74, 0.08, 18, 32), this.leatherMaterial);
    belt.rotation.x = Math.PI / 2;
    belt.position.y = -0.05;
    this.characterGroup.add(belt);

    const buckle = new THREE.Mesh(new THREE.OctahedronGeometry(0.18, 0), this.highlightMaterial);
    buckle.position.set(0, -0.05, 0.55);
    this.characterGroup.add(buckle);
    this.#registerAccentMaterial(buckle.material);

    const capeGeometry = new THREE.PlaneGeometry(2.6, 3.1, 1, 10);
    const capeMaterial = new THREE.MeshStandardMaterial({
      color: 0x1e293b,
      roughness: 0.95,
      metalness: 0.1,
      side: THREE.DoubleSide,
    });
    capeGeometry.translate(0, -1.55, 0);
    const cape = new THREE.Mesh(capeGeometry, capeMaterial);
    cape.castShadow = true;
    cape.position.set(0, 1.7, -0.55);
    cape.rotation.x = -0.25;
    this.characterGroup.add(cape);
    this.capeMesh = cape;

    const shoulderPadGeometry = new THREE.SphereGeometry(0.42, 24, 24, 0, Math.PI * 2, 0, Math.PI / 1.2);
    const leftShoulder = new THREE.Mesh(shoulderPadGeometry, this.armorMaterial);
    leftShoulder.position.set(-0.95, 1.3, 0);
    leftShoulder.rotation.z = Math.PI / 2;
    leftShoulder.castShadow = true;
    this.characterGroup.add(leftShoulder);

    const rightShoulder = leftShoulder.clone();
    rightShoulder.position.x = 0.95;
    this.characterGroup.add(rightShoulder);

    const shoulderTrimGeometry = new THREE.TorusGeometry(0.38, 0.06, 12, 32);
    const leftTrim = new THREE.Mesh(shoulderTrimGeometry, this.primaryMaterial);
    leftTrim.position.set(-0.95, 1.32, 0);
    leftTrim.rotation.x = Math.PI / 2;
    this.characterGroup.add(leftTrim);
    this.#registerAccentMaterial(leftTrim.material);

    const rightTrim = leftTrim.clone();
    rightTrim.position.x = 0.95;
    this.characterGroup.add(rightTrim);

    const head = new THREE.Mesh(new THREE.SphereGeometry(0.55, 32, 32), this.skinMaterial);
    head.castShadow = true;
    head.position.y = 2.05;
    this.characterGroup.add(head);
    this.head = head;

    const brow = new THREE.Mesh(new THREE.BoxGeometry(0.7, 0.08, 0.12), this.secondaryMaterial);
    brow.position.set(0, 0.12, 0.5);
    head.add(brow);

    const hair = new THREE.Mesh(
      new THREE.SphereGeometry(0.72, 32, 32, 0, Math.PI * 2, Math.PI / 2.2, Math.PI / 1.6),
      this.secondaryMaterial,
    );
    hair.scale.set(1, 0.85, 1);
    hair.position.set(0, 0.05, -0.15);
    head.add(hair);

    const leftEye = new THREE.Mesh(new THREE.SphereGeometry(0.08, 16, 16), this.eyeMaterial);
    leftEye.position.set(-0.18, 0.08, 0.52);
    head.add(leftEye);

    const rightEye = leftEye.clone();
    rightEye.position.x = 0.18;
    head.add(rightEye);

    const pupilMaterial = new THREE.MeshStandardMaterial({ color: 0x0f172a, roughness: 0.5, metalness: 0.1 });
    const leftPupil = new THREE.Mesh(new THREE.SphereGeometry(0.04, 12, 12), pupilMaterial);
    leftPupil.position.set(-0.18, 0.08, 0.58);
    head.add(leftPupil);

    const rightPupil = leftPupil.clone();
    rightPupil.position.x = 0.18;
    head.add(rightPupil);

    const nose = new THREE.Mesh(new THREE.ConeGeometry(0.08, 0.25, 12), this.skinMaterial);
    nose.position.set(0, -0.05, 0.58);
    nose.rotation.x = Math.PI / 2;
    head.add(nose);

    this.faceAccessoryGroup = new THREE.Group();
    head.add(this.faceAccessoryGroup);

    const collar = new THREE.Mesh(new THREE.TorusGeometry(0.45, 0.08, 16, 32), this.primaryMaterial);
    collar.rotation.x = Math.PI / 2;
    collar.position.set(0, 1.58, 0);
    this.characterGroup.add(collar);
    this.#registerAccentMaterial(collar.material);

    const createArm = (side = 1) => {
      const armGroup = new THREE.Group();

      const shoulder = new THREE.Mesh(new THREE.SphereGeometry(0.34, 24, 24), this.armorMaterial);
      shoulder.castShadow = true;
      shoulder.position.set(0.92 * side, 1.3, 0);
      this.characterGroup.add(shoulder);

      const upperArm = new THREE.Mesh(new THREE.CylinderGeometry(0.22, 0.25, 1.05, 16), this.leatherMaterial);
      upperArm.castShadow = true;
      upperArm.position.y = -0.15;
      armGroup.add(upperArm);

      const vambrace = new THREE.Mesh(new THREE.CylinderGeometry(0.24, 0.28, 0.55, 16), this.armorMaterial);
      vambrace.position.y = -0.55;
      armGroup.add(vambrace);

      const bracerGlow = new THREE.Mesh(new THREE.TorusGeometry(0.26, 0.05, 12, 24), this.primaryMaterial);
      bracerGlow.rotation.x = Math.PI / 2;
      bracerGlow.position.y = -0.4;
      armGroup.add(bracerGlow);
      this.#registerAccentMaterial(bracerGlow.material);

      const handGroup = new THREE.Group();
      handGroup.position.y = -0.85;
      armGroup.add(handGroup);

      const palm = new THREE.Mesh(new THREE.SphereGeometry(0.18, 16, 16), this.skinMaterial);
      palm.position.y = -0.08;
      handGroup.add(palm);

      armGroup.rotation.z = side === 1 ? -Math.PI / 7 : Math.PI / 7;
      armGroup.position.set(0.96 * side, 1.1, 0);

      if (side === 1) {
        this.rightHandGroup = handGroup;
      } else {
        this.leftHandGroup = handGroup;
      }

      this.characterGroup.add(armGroup);
    };

    createArm(-1);
    createArm(1);

    this.weaponGroup = new THREE.Group();
    this.offhandGroup = new THREE.Group();
    this.rightHandGroup?.add(this.weaponGroup);
    this.leftHandGroup?.add(this.offhandGroup);

    this.scene.add(this.characterGroup);

    this.#updateRaceTraits(this.raceDisplayTarget?.textContent);
    this.#updateClassLoadout(this.classDisplayTarget?.textContent);
  }

  #createEnvironment() {
    const floorMaterial = new THREE.MeshStandardMaterial({ color: 0x111827, roughness: 0.95, metalness: 0.05 });
    const floor = new THREE.Mesh(new THREE.CircleGeometry(5, 64), floorMaterial);
    floor.rotation.x = -Math.PI / 2;
    floor.position.y = -1.6;
    floor.receiveShadow = true;
    this.scene.add(floor);

    this.runeCircle = new THREE.Mesh(new THREE.RingGeometry(1.9, 2.6, 48), this.runeMaterial);
    this.runeCircle.rotation.x = -Math.PI / 2;
    this.runeCircle.position.y = -1.38;
    this.scene.add(this.runeCircle);

    const glow = new THREE.PointLight(this.runeMaterial.color, 0.6, 10);
    glow.position.set(0, 0.5, 0);
    this.scene.add(glow);

    this.groundGlow = glow;
  }

  #animate() {
    this.animationFrame = requestAnimationFrame(this.boundAnimate);

    if (this.characterGroup && !this.isDragging) {
      this.characterGroup.rotation.y += this.rotationVelocity;
    }

    if (this.capeMesh) {
      this.capeMesh.rotation.z = Math.sin(performance.now() * 0.0015) * 0.08;
    }

    if (this.runeCircle) {
      this.runeCircle.rotation.z += 0.0025;
    }

    this.renderer?.render(this.scene, this.camera);
  }

  #handlePointerDown(event) {
    if (!this.characterGroup) return;

    this.isDragging = true;
    this.rotationVelocity = 0;
    this.dragStartX = event.clientX;
    this.dragStartRotation = this.characterGroup.rotation.y;
    this.previousDragX = event.clientX;
  }

  #handlePointerMove(event) {
    if (!this.isDragging || !this.characterGroup) return;

    const width = this.viewportTarget.clientWidth || 1;
    const delta = (event.clientX - this.dragStartX) / width * Math.PI;
    this.characterGroup.rotation.y = this.dragStartRotation + delta;

    this.lastDragDelta = event.clientX - this.previousDragX;
    this.previousDragX = event.clientX;
  }

  #handlePointerUp() {
    if (!this.isDragging) return;

    this.isDragging = false;
    const width = this.viewportTarget.clientWidth || 1;
    this.rotationVelocity = (this.lastDragDelta / width) * Math.PI * 0.08;
  }

  #resize() {
    if (!this.renderer || !this.camera) return;

    const width = this.viewportTarget.clientWidth || 1;
    const height = this.viewportTarget.clientHeight || 1;

    this.renderer.setSize(width, height, false);
    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();
  }

  #accentColorFor(value) {
    if (!value) return 0xf97316;

    const slug = value
      .toString()
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-");

    const palette = {
      barbarian: 0xb91c1c,
      bard: 0xbe123c,
      cleric: 0xfacc15,
      druid: 0x4ade80,
      fighter: 0x2563eb,
      monk: 0x0891b2,
      paladin: 0xf97316,
      ranger: 0x22c55e,
      rogue: 0x0f172a,
      sorcerer: 0xdb2777,
      warlock: 0x8b5cf6,
      wizard: 0x6366f1,
    };

    return palette[slug] ?? 0xf97316;
  }

  #applyRaceAccent(value) {
    if (!value) return;

    if (!this.#hasMeaningfulText(value)) return;

    const color = this.#raceColorFor(value);
    if (this.runeMaterial) {
      this.runeMaterial.color.setHex(color);
    }
    if (this.groundGlow) {
      this.groundGlow.color.setHex(color);
    }
  }

  #updatePrimaryColor(value) {
    const color = this.#accentColorFor(value);
    this.accentMaterials?.forEach((material) => {
      material?.color?.setHex?.(color);
      material?.emissive?.setHex?.(color);
    });
  }

  #updateBackgroundFrom(value) {
    if (!this.hasImageDisplayTarget || !this.#hasMeaningfulText(value)) return;

    const fileName = value
      .toString()
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-");
    const assetPath = `/assets/${fileName}.png`;
    this.imageDisplayTarget.style.backgroundImage = `linear-gradient(180deg, rgba(15,23,42,0.65) 0%, rgba(12,10,9,0.9) 100%), url(${assetPath})`;
  }

  #previewFile(file) {
    if (!this.hasImageDisplayTarget || !file) return;

    const reader = new FileReader();
    reader.onload = (event) => {
      this.imageDisplayTarget.style.backgroundImage = `linear-gradient(180deg, rgba(15,23,42,0.65) 0%, rgba(12,10,9,0.9) 100%), url(${event.target.result})`;
    };
    reader.readAsDataURL(file);
  }

  #updateRaceTraits(value = this.raceDisplayTarget?.textContent) {
    if (!this.faceAccessoryGroup) return;

    this.#clearGroup(this.faceAccessoryGroup);

    const slug = this.#slugify(value);
    if (!slug) return;

    if (slug.includes("elf")) {
      const earMaterial = this.skinMaterial.clone();
      earMaterial.color = new THREE.Color(0xffc9a6);

      const leftEar = new THREE.Mesh(new THREE.ConeGeometry(0.18, 0.5, 12), earMaterial);
      leftEar.position.set(-0.5, 0.05, -0.02);
      leftEar.rotation.z = Math.PI / 1.8;
      this.faceAccessoryGroup.add(leftEar);

      const rightEar = leftEar.clone();
      rightEar.position.x = 0.5;
      rightEar.rotation.z = -Math.PI / 1.8;
      this.faceAccessoryGroup.add(rightEar);
    } else if (slug === "tiefling") {
      const hornMaterial = this.secondaryMaterial.clone();
      hornMaterial.color = new THREE.Color(0x5b21b6);

      const hornGeometry = new THREE.CylinderGeometry(0.12, 0.04, 0.8, 12);
      const leftHorn = new THREE.Mesh(hornGeometry, hornMaterial);
      leftHorn.position.set(-0.25, 0.35, 0.1);
      leftHorn.rotation.z = Math.PI / 4;
      this.faceAccessoryGroup.add(leftHorn);

      const rightHorn = leftHorn.clone();
      rightHorn.position.x = 0.25;
      rightHorn.rotation.z = -Math.PI / 4;
      this.faceAccessoryGroup.add(rightHorn);
    } else if (slug === "dragonborn") {
      const snout = new THREE.Mesh(new THREE.ConeGeometry(0.2, 0.6, 16), this.secondaryMaterial);
      snout.rotation.x = Math.PI / 2;
      snout.position.set(0, -0.05, 0.62);
      this.faceAccessoryGroup.add(snout);

      const crest = new THREE.Mesh(new THREE.CylinderGeometry(0.05, 0.18, 0.9, 8), this.primaryMaterial);
      crest.position.set(0, 0.35, -0.2);
      crest.rotation.x = Math.PI / 2;
      this.faceAccessoryGroup.add(crest);
      this.#registerAccentMaterial(crest.material);
    } else if (slug === "dwarf") {
      const beardMaterial = this.secondaryMaterial.clone();
      beardMaterial.color = new THREE.Color(0x92400e);
      const beard = new THREE.Mesh(new THREE.ConeGeometry(0.32, 0.75, 16), beardMaterial);
      beard.position.set(0, -0.45, 0.52);
      beard.rotation.x = Math.PI / 2;
      this.faceAccessoryGroup.add(beard);
    } else if (slug === "orc") {
      const tuskMaterial = this.trimMaterial.clone();
      tuskMaterial.color = new THREE.Color(0xe7e5e4);
      const leftTusk = new THREE.Mesh(new THREE.CylinderGeometry(0.05, 0.12, 0.3, 8), tuskMaterial);
      leftTusk.rotation.x = Math.PI / 2;
      leftTusk.position.set(-0.16, -0.2, 0.6);
      this.faceAccessoryGroup.add(leftTusk);

      const rightTusk = leftTusk.clone();
      rightTusk.position.x = 0.16;
      this.faceAccessoryGroup.add(rightTusk);
    }
  }

  #updateClassLoadout(value = this.classDisplayTarget?.textContent) {
    if (!this.weaponGroup || !this.offhandGroup) return;

    this.#clearGroup(this.weaponGroup);
    this.#clearGroup(this.offhandGroup);

    if (this.quiver) {
      this.characterGroup?.remove(this.quiver);
      this.#disposeObject(this.quiver);
      this.quiver = null;
    }

    const slug = this.#slugify(value);
    if (!slug) return;

    const buildSword = () => {
      const weapon = new THREE.Group();

      const blade = new THREE.Mesh(new THREE.BoxGeometry(0.14, 1.9, 0.12), this.trimMaterial);
      blade.castShadow = true;
      blade.position.y = 0.7;
      weapon.add(blade);

      const fuller = new THREE.Mesh(new THREE.BoxGeometry(0.03, 1.5, 0.02), this.secondaryMaterial);
      fuller.position.set(0, 0.75, 0.05);
      weapon.add(fuller);

      const guard = new THREE.Mesh(new THREE.CylinderGeometry(0.3, 0.3, 0.12, 24), this.secondaryMaterial);
      guard.rotation.x = Math.PI / 2;
      weapon.add(guard);

      const grip = new THREE.Mesh(new THREE.CylinderGeometry(0.1, 0.1, 0.6, 16), this.leatherMaterial);
      grip.position.y = -0.35;
      weapon.add(grip);

      const pommel = new THREE.Mesh(new THREE.SphereGeometry(0.14, 16, 16), this.primaryMaterial);
      pommel.position.y = -0.65;
      weapon.add(pommel);
      this.#registerAccentMaterial(pommel.material);

      weapon.rotation.z = -Math.PI / 5;
      weapon.position.set(0.35, -0.1, 0);
      return weapon;
    };

    const buildShield = () => {
      const shield = new THREE.Group();
      const base = new THREE.Mesh(new THREE.CylinderGeometry(0.7, 0.85, 0.15, 32), this.armorMaterial);
      base.rotation.x = Math.PI / 2;
      shield.add(base);

      const crest = new THREE.Mesh(new THREE.OctahedronGeometry(0.28, 0), this.highlightMaterial);
      crest.position.z = 0.18;
      shield.add(crest);
      this.#registerAccentMaterial(crest.material);

      const rim = new THREE.Mesh(new THREE.TorusGeometry(0.78, 0.08, 16, 48), this.secondaryMaterial);
      rim.rotation.x = Math.PI / 2;
      shield.add(rim);

      shield.position.set(-0.2, -0.25, 0);
      shield.rotation.y = Math.PI / 9;
      return shield;
    };

    const buildStaff = (withNatureAccent = false) => {
      const staff = new THREE.Group();

      const shaft = new THREE.Mesh(new THREE.CylinderGeometry(0.12, 0.1, 2.6, 16), withNatureAccent ? this.leatherMaterial : this.secondaryMaterial);
      shaft.position.y = 0.4;
      staff.add(shaft);

      const cap = new THREE.Mesh(new THREE.SphereGeometry(0.22, 20, 20), this.highlightMaterial);
      cap.position.y = 1.5;
      staff.add(cap);
      this.#registerAccentMaterial(cap.material);

      if (withNatureAccent) {
        const leafMaterial = this.primaryMaterial.clone();
        leafMaterial.color = new THREE.Color(0x22c55e);
        const leaf = new THREE.Mesh(new THREE.ConeGeometry(0.16, 0.6, 8), leafMaterial);
        leaf.position.set(0.25, 1.2, 0);
        leaf.rotation.z = Math.PI / 4;
        staff.add(leaf);
      }

      staff.rotation.z = Math.PI / 6;
      staff.position.set(0.2, -0.2, 0);
      return staff;
    };

    const buildBow = () => {
      const bow = new THREE.Group();

      const arcMaterial = this.leatherMaterial.clone();
      arcMaterial.color = new THREE.Color(0x4338ca);
      const arc = new THREE.Mesh(new THREE.TorusGeometry(0.75, 0.06, 12, 32, Math.PI), arcMaterial);
      arc.rotation.z = Math.PI / 2;
      bow.add(arc);

      const stringMaterial = new THREE.LineBasicMaterial({ color: 0xf8fafc });
      const points = [new THREE.Vector3(0, 0.75, 0), new THREE.Vector3(0, -0.75, 0)];
      const stringGeometry = new THREE.BufferGeometry().setFromPoints(points);
      const string = new THREE.Line(stringGeometry, stringMaterial);
      bow.add(string);

      const grip = new THREE.Mesh(new THREE.BoxGeometry(0.25, 0.5, 0.2), this.secondaryMaterial);
      bow.add(grip);

      bow.rotation.y = Math.PI / 8;
      bow.rotation.z = -Math.PI / 8;
      bow.position.set(0.2, -0.4, 0);
      return bow;
    };

    const buildDaggers = () => {
      const daggerMaterial = this.trimMaterial;
      for (let i = 0; i < 2; i += 1) {
        const dagger = new THREE.Group();
        const blade = new THREE.Mesh(new THREE.BoxGeometry(0.1, 0.9, 0.05), daggerMaterial);
        blade.position.y = 0.35;
        dagger.add(blade);

        const handle = new THREE.Mesh(new THREE.CylinderGeometry(0.06, 0.06, 0.4, 12), this.leatherMaterial);
        handle.position.y = -0.3;
        dagger.add(handle);

        dagger.rotation.z = i === 0 ? -Math.PI / 2.4 : -Math.PI / 1.9;
        dagger.position.set(0.25, i === 0 ? -0.1 : -0.4, 0);
        const targetGroup = i === 0 ? this.weaponGroup : this.offhandGroup;
        targetGroup?.add(dagger);
      }
    };

    if (["fighter", "paladin", "barbarian"].includes(slug)) {
      this.weaponGroup.add(buildSword());
      this.offhandGroup.add(buildShield());
    } else if (["cleric", "druid"].includes(slug)) {
      this.weaponGroup.add(buildStaff(true));
    } else if (["wizard", "sorcerer", "warlock"].includes(slug)) {
      this.weaponGroup.add(buildStaff());
    } else if (["ranger"].includes(slug)) {
      this.weaponGroup.add(buildBow());
      const quiver = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.18, 0.8, 12), this.leatherMaterial);
      quiver.rotation.z = Math.PI / 2.4;
      quiver.position.set(-0.45, 1, -0.4);
      this.characterGroup.add(quiver);
      this.quiver = quiver;
    } else if (["rogue", "monk"].includes(slug)) {
      buildDaggers();
    } else {
      this.weaponGroup.add(buildStaff());
    }
  }

  #clearGroup(group) {
    if (!group) return;
    while (group.children.length > 0) {
      const child = group.children.pop();
      this.#disposeObject(child);
      group.remove(child);
    }
  }

  #registerAccentMaterial(material) {
    if (!this.accentMaterials) {
      this.accentMaterials = new Set();
    }
    this.accentMaterials.add(material);
  }

  #disposeObject(object) {
    if (!object) return;
    if (typeof object.traverse === "function") {
      object.traverse((child) => {
        if (child.isMesh || child.isLine) {
          child.geometry?.dispose?.();
        }
      });
    } else if (object.isMesh) {
      object.geometry?.dispose?.();
    } else if (object.isLine) {
      object.geometry?.dispose?.();
    }
    object.clear?.();
  }

  #slugify(value) {
    if (!this.#hasMeaningfulText(value)) return null;
    return value
      .toString()
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/(^-|-$)/g, "");
  }

  get #aspectRatio() {
    const width = this.viewportTarget?.clientWidth || 1;
    const height = this.viewportTarget?.clientHeight || 1;
    return width / height;
  }

  #raceColorFor(value) {
    if (!this.#hasMeaningfulText(value)) return 0x60a5fa;

    const slug = value
      .toString()
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-");

    const palette = {
      elf: 0x22d3ee,
      dwarf: 0xf97316,
      human: 0xa855f7,
      halfling: 0x14b8a6,
      tiefling: 0xef4444,
      dragonborn: 0x38bdf8,
      gnome: 0x84cc16,
      orc: 0x65a30d,
    };

    return palette[slug] ?? 0x60a5fa;
  }

  #hasMeaningfulText(value) {
    if (!value) return false;
    return /[a-z0-9]/i.test(value.toString());
  }
}
