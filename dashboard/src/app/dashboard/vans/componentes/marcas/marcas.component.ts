import { MessageService } from './../../../../shared/services/mensage.service';
import { Marca } from './../../../../models/marca.model';
import { ResponseVans } from './../../models/vans';
import { VansService } from './../../../viagens/services/vans.service';
import { Subscription } from 'rxjs/internal/Subscription';
import { Component, Input, OnDestroy, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { finalize } from 'rxjs/operators';
import { MarcasService } from '../../services/marcas.service';
import { ListaMarcas } from '../../models/listaMarcas.model';
import { SwalService } from 'src/app/services/swal.service';
import { Van } from '../../../vans/models/vans';

@Component({
  selector: 'app-marcas',
  templateUrl: './marcas.component.html',
  styleUrls: ['./marcas.component.css']
})
export class MarcasComponent implements OnInit, OnDestroy {
  listAllMarcas: any;
  formaddmarca: any;
  loading: boolean = true;
  van: Van[];
  arraySubscription: Array<Subscription> = new Array<Subscription>();

  constructor(private marcasService: MarcasService,
    public fb: FormBuilder,
    private createMarcaService: MarcasService,
    private swal: SwalService,
    private vansService: VansService,
    private messageService: MessageService
  ) {
    this.formaddmarca = fb.group({
      nome: ['', Validators.required]
    });
  }



  ngOnInit() {
    this.getAllMarcas();
  }

  ngOnDestroy(): void {
    this.arraySubscription.map((subscription: Subscription) => subscription.unsubscribe());
  }

  deleteMarca(id: number) {

  }

  delete(dados: Marca) {
    const handlerCallback = () => {
      this.loading = true;
      const vansSubscriptions = this.vansService.getAll()
        .subscribe((res: ResponseVans) => {
          let temDados = res.data.vans.map(modelo => modelo.modelo).filter(modelo => modelo.marca_id == dados.id)

          if (temDados.length == 0) {
            const marcaSubscriptions = this.createMarcaService.delete(+dados.id).pipe(
              finalize(() => { this.loading = false; })
            ).subscribe(
              (resp) => {
                this.loading = false;
                this.messageService.mensage('Sucesso', `A marca <strong> ${dados.nome} </strong>  elimanado com sucesso!`, 'success');
                this.getAllMarcas();
              },
              (error) => {
                this.loading = false;
              }
            );
            this.arraySubscription = [...this.arraySubscription, marcaSubscriptions];
            this.loading = false;
          } else {
            this.loading = false;
            this.messageService.mensage('Alerta', `A marca <strong> ${dados.nome} </strong> Esta vinculado a uma Van!`, 'warning');
          }
        });
      this.arraySubscription = [...this.arraySubscription, vansSubscriptions];
    };

    this.swal.swalConfirmation(
      'Eliminar Marca',
      `Deseja eliminar os veiculos de marca ${dados.nome}?`,
      'warning',
      `Sim, eliminar`,
      handlerCallback
    );
  }


  createMarca() {
    this.formaddmarca.disable();

    const marcaSubscriptions = this.createMarcaService.create(this.formaddmarca.value)
      .subscribe(
        (sucesso: any) => {
          if (sucesso.message[0] === 'The nome has already been taken.') {
            this.messageService.mensage('Marca Existente', 'Marca jé exite no sitema!', 'warning');
            this.formaddmarca.enable();
          }
          else {
            this.messageService.mensage('Sucesso', `Marca foi cadastrada!`, 'success');
            this.getAllMarcas();
            this.formaddmarca.enable();
            this.formaddmarca.reset();
          }
        },
        (error) => {
          this.messageService.mensage('Sucesso', `Marca foi cadastrada!`, 'success');
          this.formaddmarca.enable();
        }
      )

    this.arraySubscription = [...this.arraySubscription, marcaSubscriptions];
  }
  get nome() { return this.formaddmarca.get('nome'); }

  getAllMarcas() {
    const marcaSubscriptions = this.marcasService.getAll().pipe(
      finalize(() => {
        this.loading = false;
      })
    ).subscribe(
      (resp: ListaMarcas) => {
        this.listAllMarcas = resp.data;
        this.listAllMarcas = this.listAllMarcas.marcas;
      }
    )

    this.arraySubscription = [...this.arraySubscription, marcaSubscriptions];
  }

}
