import { Component, OnInit } from '@angular/core';
import { MarcasService } from '../../services/marcas.service';
import { ListaMarcas } from '../../models/listaMarcas.model';
import { ModelosService } from '../../services/modelos.service';
import { FormBuilder, Validators } from '@angular/forms';
import { SwalService } from 'src/app/services/swal.service';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-modelos',
  templateUrl: './modelos.component.html',
  styleUrls: ['./modelos.component.css']
})
export class ModelosComponent implements OnInit {

  listAllMarcas: any;
  listamodelos: any;
  formulario: any;
  modelo_id: number;
  listamodelo_id: number;
  loading: boolean = true;

  constructor(
    private marcasService: MarcasService,
    private modelos: MarcasService,
    private fb: FormBuilder,
    private modelosService: ModelosService,
    private swal: SwalService
  ) {
    this.formulario = this.fb.group({
      nome: ['', Validators.required],
      marca_id: ['', Validators.required]
    });
  }

  getAllMarcas(){
    this.marcasService.getAll().pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).subscribe(
      (resp: ListaMarcas) => {
        this.listAllMarcas = resp.data;
        this.listAllMarcas = this.listAllMarcas.marcas;
        
      }
    )
  }
  get nome() { return this.formulario.get('nome'); }
  get marca_id() { return this.formulario.get('marca_id');}

  ngOnInit() {
    this.getAllMarcas();
  }

  listModelos(id){
    this.listamodelo_id = id;
    this.modelos.getById(this.listamodelo_id).subscribe(
      (res) => {
        this.listamodelos = res;
        this.listamodelos = this.listamodelos.data.marca[0];

      }
    );
  }

  createMarca() {

    const dataForm = this.formulario.value;

    this.modelosService.create(dataForm).subscribe(
      (res: any) => {
        
        if (res.data.modelo.id) {
          this.swal.swalTitleText('Cadastro', `Van de modelo ${res.modelo.nome} foi adicionada`, 'success');
        } else {
          this.swal.swalTitleText('Cadastro', `Não foi possível adicionar novo modelo`, 'error');
        }

        if (this.listamodelo_id) {
          this.listModelos(this.listamodelo_id);
        }

      }
    );

  }

  delete(dados: any) {


    const handlerCallback = () => {

    this.modelosService.delete(+dados.id).subscribe(
        (res) => {
          
          if (this.listamodelo_id) {
            this.listModelos(this.listamodelo_id);
          }
          this.swal.swalCustom('Van Eliminada', `A van de modelo <strong> ${dados.nome} <strong> foi removido!`, 1000, true)
        },
        (error) => {

          this.swal.swalTitleText('Eliminar van', `Não foi possível eminimar a van de modelo ${dados.nome}`, 'error');

        }

      );
    };

    
    this.swal.swalConfirmation(
        'Eliminar',
        `Deseja eliminar a van de modelo ${dados.nome}?`,
        'warning',
        `Sim, eliminar`,
        handlerCallback
      );


  }

}
