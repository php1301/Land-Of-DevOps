terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("terraform-playground-299612-518d9e0a40fc.json")

  project = "terraform-playground-299612"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}

resource "google_compute_instance" "default" {
    count = 3
  name         = "terraform-gcp-mock-${count.index}"
  machine_type = "n1-standard-2"
  zone         = "asia-southeast1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  // Local SSD disk
#   scratch_disk {
#     interface = "SCSI"
#   }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }
  scheduling {
    #   bat preemtible thi automatic restart false
    preemptible = true
    automatic_restart = false
  }
    
#   metadata_startup_script = "echo hi > /test.txt"

#   service_account {
#     scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }
}