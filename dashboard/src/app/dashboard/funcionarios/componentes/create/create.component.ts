import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FormBuilder, FormArray, Validators } from '@angular/forms';
import { Funcionarios } from 'src/app/models/funcionarios.model';
import { createFuncionario } from '../../models/createFuncionario.model';
import { SwalService } from 'src/app/services/swal.service';
import { MunicipiosService } from 'src/app/dashboard/services/municipios.service';
import { environment } from 'src/environments/environment';
import { FuncionariosService } from '../../services/funcionarios.service';
import { pipe } from 'rxjs';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css']
})
export class CreateComponent implements OnInit {

  api_path = environment.API_PATH;
  usuario: any;
  municipios: any;
  funcionario: Funcionarios;

  fileData: any;
  uploaded: string = `${this.api_path}/uploads/funcionarios/default.jpg`;
  submitted: boolean;
  loading: boolean = true;

  mask = {
    matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
    telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
    bi: [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/]
  };

  constructor(private fb: FormBuilder,
    private funcionarioService: FuncionariosService,
    private cd: ChangeDetectorRef,
    private swalService: SwalService,
    private municipiosService: MunicipiosService
  ) { }

  ngOnInit() {

    this.usuario = this.fb.group({
      nome: ['', Validators.required],
      nacionalidade: ['', Validators.required],
      genero: ['M', Validators.required],
      data_nascimento: ['', Validators.required],
      nr_bi: ['', Validators.required],
      nif: [''],
      imagem: [''],
      roles: ['3', Validators.required],
      usuario: this.fb.group({
        name: [''],
        email: ['', [Validators.email, Validators.required]],
        password: [''],
      }),
      contactos: this.fb.array([
        this.fb.group({
          contacto: ['', Validators.required],
          tipo: 'Telefone'
        })
      ]),
      morada: this.fb.group({
        municipio_id: ['', Validators.required],
        bairro: ['', Validators.required],
        rua: [''],
        numero_casa: ['']
      }),

    });

    this.pesquisaMunicipios();


  }
  // Fim do construtor

  get f() { return this.usuario.controls; }
  get fu() {  return this.usuario.get('usuario').controls;  }
  get fm() {  return this.usuario.get('morada').controls; }

  pesquisaMunicipios() {
    this.municipiosService.getMunicipios().pipe(
      finalize(()=> {
        this.loading =false;
      })
    ).subscribe(
      (res) => {
        this.municipios = res;
        this.municipios = this.municipios.municipios;
        
      },
      (error) => {
        
      }
    )
  }

  pesquisaBairro() {

  }

  onReset() {
    this.submitted = false;
    this.usuario.reset();
  }

  // Metodo que retorna o campo contacto no template
  get contacto() {
    return this.usuario.get('contactos') as FormArray;
  }
  // Metodo responsavel para acrescer campos contacto no formulario
  addContacto() {

    this.contacto.push(
      this.fb.group({
        contacto: ['', Validators.required],
        tipo: ['Telefone']
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
      // need to run CD since file load runs outside of zone
      this.cd.markForCheck();
    };

  }

  // Metodo responsavel por fazer a subscrição do serviço de cadastro.
  create() {

    this.submitted = true;

    if (this.usuario.invalid) {
      this.swalService.swalTitleText('Erro ao Processar o cadastro', `Por favor preencha todos os campos!`, 'error');
      return false;
    }

    const dados: createFuncionario = {


      nome: this.usuario.value.nome,
      nacionalidade: this.usuario.value.nacionalidade,
      genero: this.usuario.value.genero,
      data_nascimento: this.usuario.value.data_nascimento,
      nr_bi: this.usuario.value.nr_bi,
      nif: this.usuario.value.nr_bi,
      imagem: this.fileData,
      usuario: {
        name: this.usuario.value.nome,
        email: this.usuario.value.usuario.email,
        password: 'Jupiter2019'
      },
      contactos: this.usuario.value.contactos,
      morada: {
        rua: this.usuario.value.morada.rua,
        bairro: this.usuario.value.morada.bairro,
        numero_casa: this.usuario.value.morada.numero_casa,
        municipio_id: this.usuario.value.morada.municipio_id
      },
      roles: [this.usuario.get('roles').value]
    };

    this.funcionarioService.create(dados).subscribe(
      (res: any) => {
        if (res.status === 'fail') {
          this.swalService.swalTitleText('Cadastro de Funcionário', `O colaborador ${dados.nome}  foi cadastrado`, 'error');
        } else {
          this.swalService.swalTitleText('Cadastro de Funcionário', `O colaborador ${dados.nome} foi cadastrado`, 'success');
          this.onReset();
        }
      },
      (error) => {
        

      }
    )

  }

}
