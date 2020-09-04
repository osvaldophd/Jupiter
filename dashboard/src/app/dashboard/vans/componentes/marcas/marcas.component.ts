import { Component, OnInit } from '@angular/core';
import { MarcasService } from '../../services/marcas.service';
import { ListaMarcas } from '../../models/listaMarcas.model';
import { FormBuilder, Validators } from '@angular/forms';
import { SwalService } from 'src/app/services/swal.service';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-marcas',
  templateUrl: './marcas.component.html',
  styleUrls: ['./marcas.component.css']
})
export class MarcasComponent implements OnInit {

  listAllMarcas: any;
  formaddmarca: any;
  loading: boolean = true;

  constructor( private marcasService: MarcasService,
               public fb: FormBuilder,
               private createMarcaService: MarcasService,
               private swal: SwalService
               ) {
    this.formaddmarca = fb.group({
        nome: ['', Validators.required]
    });
  }

  deleteMarca(id: number){

  }

  delete(dados: any) {

    const handlerCallback = () => {
      this.createMarcaService.delete(+dados.id).subscribe(
        (resp) => {
          this.swal.swalCustom('Veicolos Eliminados', `Os veiculos de marca <strong> ${dados.nome} </strong>  foram removidos!`, 1000, true)
          this.getAllMarcas();
        }
      );
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

    this.createMarcaService.create(this.formaddmarca.value).subscribe(
      (rescrate: any) => {
        
        this.swal.swalTitleText('Cadastro de Veiculo', `A marca de veiculos ${rescrate.data.marca.nome} foi adicionada`, 'success');
        this.getAllMarcas();
      }
    )

  }
  get nome() { return this.formaddmarca.get('nome'); }

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

  ngOnInit() {
    this.getAllMarcas();
  }

}
