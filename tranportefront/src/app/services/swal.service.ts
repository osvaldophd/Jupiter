import { Injectable } from '@angular/core';
import swal from 'sweetalert2';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class SwalService {

  constructor(private router: Router) { }

  swalCustom(title: string, html: string, timer: number, timerProgressBar: boolean) {
    let timerInterval;
    swal.fire({
      title,
      html,
      timer,
      timerProgressBar,
      allowOutsideClick: false,
      onOpen: () => {
        swal.showLoading();
        timerInterval = setInterval(() => {
          swal.getContent().querySelector('strong');
        }, 100);
      },
      onClose: () => {
        clearInterval(timerInterval);
      }
    }).then((result) => {
      if (
        // Read more about handling dismissals
        result.dismiss === swal.DismissReason.timer
      ) {
      }
    });
  }

    swalIntDismiss(title: string, html: string, timerProgressBar: boolean) {

      let timerInterval;
      swal.fire({
        title,
        html,
        timer: 2000,
        timerProgressBar,
        allowOutsideClick: false,
        onOpen: () => {
          swal.showLoading();
          timerInterval = setInterval(() => {
             swal.getContent().querySelector('strong');
          }, 100);
        },
        onClose: () => {
          clearInterval(timerInterval);
        }
      }).then((result) => {
        if (
          // Read more about handling dismissals
          result.dismiss === swal.DismissReason.timer
        ) {
          this.router.navigate(['/login']);
        }
      });
  }
  swalTitleText(title: string, desc: string, icon: any ) {
    swal.fire(
      `${title}`,
      `${desc}`,
      icon
    );
  }

  swalWithFooter(title: string,  html: string, fter: string) {
    swal.fire({
      title,
      html: `${html}`,
      footer: `${fter}`
    });
  }

  swalwidth(title: string, width: number, html) {
    swal.fire( {
      title,
      width,
      html
    });
  }

  swalImage(ttl: string, txt: string, imageUrl: string, imageAlt: string) {
    swal.fire({
      title: ttl,
      text: txt,
      imageUrl,
      imageWidth: 400,
      imageHeight: 200,
      imageAlt: 'Custom image',
      animation: false
    });
  }

  swalConfirmation(title, text, icon, confirmButtonText, callback ) {
    swal.fire({
      title,
      text,
      icon,
      showCancelButton: true,
      confirmButtonColor: '#ba1720',
      cancelButtonColor: '#ddd',
      confirmButtonText
    }).then((result) => {
      if (result.value) {

        callback();

      } else {
        this.swalCustom('Operacão Cancelada', 'A abortar a operação', 900, true);
      }

    });
  }


  swalToast() {
      const Toast = swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        onOpen: (toast) => {
          toast.addEventListener('mouseenter', swal.stopTimer)
          toast.addEventListener('mouseleave', swal.resumeTimer)
        }
      });

      Toast.fire({
        icon: 'success',
        title: 'Signed in successfully'
      });
  }

  swalItervalRedirect(title: string, html: string, timer: number, timerProgressBar: boolean, router: string) {
    let timerInterval;
    swal.fire({
      title,
      html,
      timer,
      timerProgressBar,
      allowOutsideClick: false,
      onOpen: () => {
        swal.showLoading();
        timerInterval = setInterval(() => {
          swal.getContent().querySelector('strong');
        }, 100);
      },
      onClose: () => {
        clearInterval(timerInterval);
      }
    }).then((result) => {
      if (
        // Read more about handling dismissals
        result.dismiss === swal.DismissReason.timer
      ) {
        this.router.navigate([router]);
      }
    });
  }

  /* swalHtml(title: string, type: any, html: string) {
    swal.fire({
      title,
      html,
    });
  } */
}


