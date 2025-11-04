# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "three", to: "https://ga.jspm.io/npm:three@0.161.0/build/three.module.js"
pin_all_from "app/javascript/controllers", under: "controllers"
