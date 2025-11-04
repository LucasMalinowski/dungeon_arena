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

    this.primaryMaterial = new THREE.MeshStandardMaterial({
      color: this.#accentColorFor(this.classDisplayTarget?.textContent),
      metalness: 0.35,
      roughness: 0.45,
    });
    this.secondaryMaterial = new THREE.MeshStandardMaterial({
      color: 0x0f172a,
      metalness: 0.15,
      roughness: 0.75,
    });
    this.skinMaterial = new THREE.MeshStandardMaterial({ color: 0xffd8b1, roughness: 1 });
    this.runeMaterial = new THREE.MeshBasicMaterial({
      color: this.#raceColorFor(this.raceDisplayTarget?.textContent),
      transparent: true,
      opacity: 0.5,
    });

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

    const body = new THREE.Mesh(new THREE.CapsuleGeometry(0.85, 1.8, 12, 24), this.primaryMaterial);
    body.castShadow = true;
    body.position.y = 0.45;
    this.characterGroup.add(body);

    const head = new THREE.Mesh(new THREE.SphereGeometry(0.55, 32, 32), this.skinMaterial);
    head.castShadow = true;
    head.position.y = 1.95;
    this.characterGroup.add(head);

    const hood = new THREE.Mesh(new THREE.SphereGeometry(0.72, 32, 32, 0, Math.PI * 2, 0, Math.PI / 1.8), this.secondaryMaterial);
    hood.scale.set(1, 0.7, 1);
    hood.position.y = 1.9;
    hood.castShadow = true;
    this.characterGroup.add(hood);

    const belt = new THREE.Mesh(new THREE.TorusGeometry(0.72, 0.09, 16, 32), this.secondaryMaterial);
    belt.rotation.x = Math.PI / 2;
    belt.position.y = -0.2;
    this.characterGroup.add(belt);

    const createArm = (side = 1) => {
      const armGroup = new THREE.Group();

      const upperArm = new THREE.Mesh(new THREE.CylinderGeometry(0.18, 0.22, 1.4, 16), this.primaryMaterial);
      upperArm.castShadow = true;
      upperArm.position.y = 0;
      armGroup.add(upperArm);

      const bracer = new THREE.Mesh(new THREE.TorusGeometry(0.21, 0.05, 12, 24), this.secondaryMaterial);
      bracer.rotation.x = Math.PI / 2;
      bracer.position.y = -0.4;
      armGroup.add(bracer);

      const hand = new THREE.Mesh(new THREE.SphereGeometry(0.18, 16, 16), this.skinMaterial);
      hand.position.y = -0.7;
      armGroup.add(hand);

      armGroup.rotation.z = side === 1 ? -Math.PI / 6 : Math.PI / 6;
      armGroup.position.set(0.95 * side, 0.4, 0);

      return armGroup;
    };

    const leftArm = createArm(-1);
    const rightArm = createArm(1);
    this.characterGroup.add(leftArm);
    this.characterGroup.add(rightArm);

    const swordGroup = new THREE.Group();
    swordGroup.position.set(1.4, -0.4, 0.2);
    swordGroup.rotation.z = -Math.PI / 4;

    const blade = new THREE.Mesh(new THREE.BoxGeometry(0.15, 1.8, 0.1), new THREE.MeshStandardMaterial({ color: 0xf8fafc, metalness: 0.95, roughness: 0.1 }));
    blade.castShadow = true;
    blade.position.y = 0.4;
    swordGroup.add(blade);

    const guard = new THREE.Mesh(new THREE.CylinderGeometry(0.25, 0.25, 0.12, 24), this.secondaryMaterial);
    guard.rotation.x = Math.PI / 2;
    swordGroup.add(guard);

    const handle = new THREE.Mesh(new THREE.CylinderGeometry(0.08, 0.08, 0.5, 16), this.primaryMaterial);
    handle.position.y = -0.35;
    swordGroup.add(handle);

    rightArm.add(swordGroup);

    this.scene.add(this.characterGroup);
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
    this.primaryMaterial?.color.setHex(color);
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
