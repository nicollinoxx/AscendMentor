import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="upload-preview"
export default class extends Controller {
  static targets = ['file', 'fileInput', 'remove'];

  connect() {
    this.currentFile = this.fileTarget.src;
  }

  preview() {
    const previewFile = this.fileInputTarget.files[0];

    if (previewFile) {
      const reader  = new FileReader();
      reader.onload = () => (this.fileTarget.src = reader.result);
      reader.readAsDataURL(previewFile);

      this.removeTarget.hidden = false;
    }
  }

  removePreview() {
    this.fileTarget.src        = this.currentFile;
    this.removeTarget.hidden   = true;
    this.fileInputTarget.value = "";
  }
}
