import { Controller } from "@hotwired/stimulus";

// Funções utilitárias simplificadas
const getCookie = name => document.cookie.split('; ').find(row => row.startsWith(name + '='))?.split('=')[1];
const setCookie = (name, value) => document.cookie = `${name}=${value}; path=/; max-age=31536000`;

export default class extends Controller {
  static targets = ["button"];

  connect() {
    const theme = getCookie("theme") || "light";
    document.documentElement.classList.add(theme);
    this.updateButtonText(theme);
  }

  toggle() {
    const newTheme = document.documentElement.classList.contains("dark") ? "light" : "dark";
    document.documentElement.classList.toggle("dark");
    this.updateButtonText(newTheme);
    setCookie("theme", newTheme);
  }

  updateButtonText(theme) {
    this.buttonTarget.textContent = theme === "dark" ? "Light" : "Dark";
  }
}
