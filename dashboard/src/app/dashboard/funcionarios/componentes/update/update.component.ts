import { MunicipiosService } from 'src/app/dashboard/services/municipios.service';
import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { FuncionariosService } from '../../services/funcionarios.service';
import { ActivatedRoute } from '@angular/router';
import { FormBuilder, FormArray, FormGroup, Validators } from '@angular/forms';
import { createFuncionario } from '../../models/createFuncionario.model';
import { Funcionario } from '../../models/funcionario.model';
import { environment } from 'src/environments/environment';
import { SwalService } from 'src/app/services/swal.service';
import { Roles } from 'src/app/contactos.model.ts/roles.model';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-update',
  templateUrl: './update.component.html',
  styleUrls: ['./update.component.css']
})
export class UpdateComponent implements OnInit {

  data: any;
  user: any;
  roles: Array<any>;
  formgroup: FormGroup;
  uploaded: string;
  fileData: any;
  submitted: boolean;
  loading: boolean = true;
  api_path = environment.API_IMG;
  municipios: any;


  mask = {
    matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
    telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
    bi: [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/]
  };

  constructor(
    private userService: FuncionariosService,
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private cd: ChangeDetectorRef,
    private swal: SwalService,
    private municipiosService: MunicipiosService
  ) {
    this.formgroup = this.fb.group({
      nome: ['', Validators.required],
      nacionalidade: ['', Validators.required],
      genero: ['', Validators.required],
      data_nascimento: ['', Validators.required],
      nr_bi: ['', Validators.required],
      nif: [''],
      imagem: [''],
      usuario_id: [''],
      usuario: this.fb.group({
        name: [''],
        email: ['', [Validators.required, Validators.email]],
        password: [''],
        roles: ['', Validators.required],
        id: ['']
      }),
      contactos: this.fb.array([
        this.fb.group({
          contacto: ['', Validators.required],
          tipo: ['Telefone'],
          id: ['']
        })
      ]),
      morada: this.fb.group({
        usuario_id: [''],
        municipio_id: ['', Validators.required],
        bairro: ['', Validators.required],
        rua: [''],
        numero_casa: ['']
      }),

    });

  }

  // Fim do metodo usado para fazer o upload do usuario
  ngOnInit() {
   this.pesquisaMunicipios();

    this.userService.getById(+(this.route.snapshot.params.id)).pipe(
      finalize(() => {
        this.loading = false;
      })
    )
      .subscribe(
        (res: Funcionario) => {
          this.user = res;
          this.user = this.user.data.funcionario[0];
          this.roles = this.user.usuario.roles;
          const imagem = this.api_path + 'uploads/funcionarios/' + this.user.imagem;
          const telefones: Array<any> = this.user.contactos || [];
          this.uploaded = imagem;
          this.user.imagem = null;
          this.formgroup.patchValue(this.user);
          this.contacto.clear();
          telefones.forEach(data => {
            this.contacto.push(
              this.fb.group({
                contacto: [data.contacto, Validators.required],
                tipo: ['Telefone'],
                id: [data.id]
              })

            )
          })


        },
        (error) => {

        }
      );
  }

  // Metodo que retorna o campo contacto no template
  get contacto() { return this.formgroup.get('contactos') as FormArray; }

  get f() { return this.formgroup.controls }

  // Metodo responsavel por fazer o update do usuário

  update() {

    this.submitted = true;
    var role: any = this.formgroup.get('usuario').get('roles').value;
    role = (typeof role == 'object') ? role[0].id : role

    const dados: createFuncionario = {
      nome: this.formgroup.get('nome').value,
      nacionalidade: this.formgroup.value.nacionalidade,
      genero: this.formgroup.value.genero,
      data_nascimento: this.formgroup.value.data_nascimento,
      nr_bi: this.formgroup.value.nr_bi,
      nif: this.formgroup.value.nr_bi,
      imagem: this.fileData,
      usuario: {
        id: this.user['usuario'].id,
        name: this.formgroup.value.nome,
        email: this.formgroup.value.usuario.email,
        password: 'test1234',
        roles: [role]
      },
      contactos: this.formgroup.value.contactos,
      morada: {
        rua: this.formgroup.value.morada.rua,
        bairro: this.formgroup.value.morada.bairro,
        numero_casa: this.formgroup.value.morada.numero_casa,
        municipio_id: this.formgroup.value.morada.municipio_id
      },

      roles: [role]

    };


    this.userService.update(+this.route.snapshot.params.id, dados).subscribe(
      (res) => {
        if (res['message'] === 'funcionario_actualizada_com_succeso')
          this.swal.swalTitleText('Sucesso', `Dados do colaborador ${dados.nome} alterado com sucesso`, 'success');
        else
          this.swal.swalTitleText('Editar Colaborador', `Erro! Não foi possivel alterar os dados`, 'error');

      },
      (error) => {
        this.swal.swalTitleText('Editar Colaborador', `Erro! Não foi possivel alterar os dados`, 'error');

      }
    );


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

  addContacto() {

    this.contacto.push(
      this.fb.group({
        contacto: ['', Validators.required],
        tipo: ['Telefone'],
      })
    );
  }

  verifyRoles(items: Array<any>, value: number): boolean {
    var r: boolean = false
    if (items) { items.find(elemento => { if (elemento.id == value) { r = true; } }) } return r;
  }

  removeContacto(item) {
    this.contacto.removeAt(item)

  }

  pesquisaMunicipios() {
    this.municipiosService.getMunicipios().pipe(
      finalize(()=> {
        this.loading = false;
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

  verificaMunicipio(item: number){

  }

  pesquisaBairro(){

  }

}
