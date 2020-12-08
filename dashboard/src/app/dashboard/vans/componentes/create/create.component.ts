import { MessageService } from './../../../../shared/services/mensage.service';
import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormBuilder, FormArray, Validators } from '@angular/forms';
import { VansService } from '../../services/vans.service';
import { CreateVan } from '../../models/createVan.model';
import { MarcasService } from '../../services/marcas.service';
import { ListaMarcas } from '../../models/listaMarcas.model';
import { SwalService } from 'src/app/services/swal.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit {

  api_path: string = environment.API_IMG;
  form: any;
  van: CreateVan;
  listamarcas: any;
  listamodelos: any;
  fileData: any;
  fileImg: any
  defaultImg: string = this.api_path + 'uploads/vans/defaultvan.png';
  idmarca: number;
  submitted: boolean;
  f: any;
  mask = {
    matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
    telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
    bi: [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/]
  };

  // tslint:disable-next-line: variable-name
  bd_marcas: { id: number, marca: string }[];



  // tslint:disable-next-line: max-line-length
  constructor(
    private fb: FormBuilder,
    private vanservice: VansService,
    private marcasService: MarcasService, private modeloService: MarcasService,
    private cd: ChangeDetectorRef,
    private messageService: MessageService

  ) {


    // Fim do form Builder


  }

  ngOnInit() {

    this.form = this.fb.group({
      marca: ['', Validators.required],
      matricula: ['', Validators.required],
      descricao: ['', Validators.required],
      modelo: ['', Validators.required],
      cor_id: [''],
      imagem: [''],
      nr_ocupantes: ['', Validators.required],
      ano_aquisicao: ['', Validators.required],
      contactos: this.fb.array([
        this.fb.group({
          contacto: ['', Validators.required]
        })
      ])

    });

    this.VerMarcas();

  }

  get fv() { return this.form.controls; }
  get contacto() { return this.form.get('contactos') as FormArray }

  addContacto() {

    this.contacto.push(
      this.fb.group({
        contacto: ['', Validators.required]
      })
    );
  }

  removeContacto(item) {
    this.contacto.removeAt(item)

  }

  readphoto(event) {

    const reader = new FileReader();
    const [file] = event;
    reader.readAsDataURL(file);
    reader.onload = () => {
      this.fileData = reader.result;
      this.fileImg = reader.result;
      // need to run CD since file load runs outside of zone
      this.cd.markForCheck();
    };

  }

  VerMarcas() {
    this.marcasService.getAll().subscribe(
      (marcas: ListaMarcas) => {
        this.listamarcas = marcas.data;
        this.listamarcas = this.listamarcas.marcas;
      }
    );
  }

  selectMarca(idmarca: number) {
    this.modeloService.getById(idmarca).subscribe(
      (resp: ListaMarcas) => {
        this.listamodelos = resp.data;
        this.listamodelos = this.listamodelos.marca[0].modelos;
      }
    );

  }

  create() {
    this.submitted = true;
    this.f = this.form.controls;

    if (this.form.invalid) {
      this.messageService.mensage('Erro ao processar o formulário', 'Por favor, preencha todos os campos!', 'error');
      return false;
    }

    const dataVan: CreateVan = {
      matricula: this.form.value.matricula,
      descricao: this.form.value.descricao,
      modelo_id: this.form.value.modelo,
      ano_aquisicao: this.form.value.ano_aquisicao,
      nr_ocupantes: this.form.value.nr_ocupantes,
      cor_id: 3,
      imagem: this.fileData,
      contactos: this.form.value.contactos
    };



    this.vanservice.create(dataVan)
      .subscribe(
        (res) => {

          this.messageService.mensage('Sucesso', 'Van cadastrada com sucesso', 'success');
          this.onReset();
        },
        (error: any) => {

          if (error.status === 500) {
            this.messageService.mensage('Erro no Cadastro', 'Desculpa, não foi possível cadastrar a van', 'error');
          }
        }
      )


  }



  onReset() {
    this.submitted = false;
    this.ngOnInit();
  }

}
