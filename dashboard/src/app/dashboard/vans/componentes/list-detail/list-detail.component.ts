import { Component, OnInit } from '@angular/core';
import { VansService } from '../../services/vans.service';
import { Router, ActivatedRoute } from '@angular/router';
import { environment } from 'src/environments/environment';
import { ListVans } from '../../models/listVans.model';
import { SwalService } from 'src/app/services/swal.service';
import { Subscription } from 'rxjs/internal/Subscription';
import { ResponseVanDetail, Van } from '../../models/vans';
import { finalize } from 'rxjs/operators';


@Component({
  selector: 'app-list-detail',
  templateUrl: './list-detail.component.html',
  styleUrls: ['./list-detail.component.css']
})
export class ListDetailComponent implements OnInit {

  api_path = environment.API_PATH;
  arraySubscription: Array<Subscription> = new Array<Subscription>();
  loading: boolean = true;


  van: Van;

  constructor(private vanservice: VansService,
              private router: Router,
              private route: ActivatedRoute,
              private swalService: SwalService
             ) {

   }

  delete(van: Van) {

    const handlerCallback = () => {

      this.vanservice.deteteVan(+van.id)
    .subscribe( (res) => {
      this.swalService.swalCustom('Van Eliminada', `A van <strong> ${van.modelo.nome} <strong> foi removido!`, 1000, true);
      this.router.navigate(['/vans']);

    });

    };

    this.swalService.swalConfirmation(
      'Eliminar Van',
      `Deseja eliminar a van de Modelo ${van.modelo.nome} e matricula ${van.matricula}?`,
      'warning',
      `Sim, eliminar`,
      handlerCallback
    );

  }

  ngOnInit() {

    const id: string = this.route.snapshot.params.id;
    const vansSubscription = this.vanservice.getById(+id).pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).subscribe(
      (res: ResponseVanDetail ) => {
        this.van = res.van[0];
      }
    );
    this.arraySubscription = [...this.arraySubscription, vansSubscription];

  }

}
