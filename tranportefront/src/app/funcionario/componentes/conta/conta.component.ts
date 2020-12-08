import { Component, OnInit, ChangeDetectorRef, Output , EventEmitter} from '@angular/core';
import { UsuarioService } from 'src/app/services/usuario.service';
import { FormBuilder, FormArray, FormGroup, Validators } from '@angular/forms';
import { environment } from 'src/environments/environment';
import { SwalService } from 'src/app/services/swal.service';
import { ShareContaService } from '../../services/share-conta.service';
import { finalize } from 'rxjs/operators';

@Component({
    selector: 'app-conta',
    templateUrl: './conta.component.html',
    styleUrls: ['./conta.component.css']
})
export class ContaComponent implements OnInit {

    usuario: any;
    usuarioPhoto: string;
    usuarioPhotoEdit: string;
    formgroup: FormGroup;
    formcontactos: any;
    firstContacto: any;
    fileData: any;
    apiPath: string = environment.IMGS;
    formedit: boolean = false;
    msg: boolean = false;
    loading: boolean = true;
    mensagem: string = "Carregando dados";


    
    mask = {
        matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
        telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
        bi:  [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/,  /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/ ]
      };

    constructor(
        private usuarioService: UsuarioService, 
        private formbuild: FormBuilder,
        private cd: ChangeDetectorRef,
        private serviceMessage: SwalService,
        private shareconta: ShareContaService
        ) {

        this.formgroup = this.formbuild.group({
            nome: ['', Validators.required],
            nacionalidade: ['', Validators.required],
            genero: [''],
            data_nascimento: [''],
            nr_bi: ['', Validators.required],
            email: ['', Validators.required],
            imagem: [''],
            morada: this.formbuild.group({
                municipio_id: ['', Validators.required],
                bairro: ['', Validators.required],
                rua: [''],
                numero_casa: ['']
              }),
            contactos: this.formbuild.array([
                this.formbuild.group({
                    contacto: ['', Validators.required],
                    tipo: [''],
                    id: ['']
                })
            ]),

        });

    }

    get f(){
        return this.formgroup.controls;
    }

    // Metodo que retorna o campo contacto no template
    get contacto() {
        return this.formgroup.get('contactos') as FormArray;
    }

    removeContacto(contacto){
        this.contacto.removeAt(contacto);
    }

    ngOnInit() {

        this.getUser();
    }

    readphoto(event) {

        const reader = new FileReader();
        const [file] = event;
        reader.readAsDataURL(file);
        reader.onload = () => {
          this.fileData = reader.result;
          this.usuarioPhotoEdit = this.fileData;
          // need to run CD since file load runs outside of zone
          this.cd.markForCheck();
        };
    
      }

    editarUsuario(data: boolean) {
        this.formedit = data;
    }

    addContacto() {

        this.contacto.push(
            this.formbuild.group({
                contacto: ['', Validators.required],
                tipo: "telemovel"
            })
        );
    }
    y(item) {
        this.contacto.removeAt(item)
      }

    getUser() {

        this.usuarioService.getUsuario()
        .pipe(
            finalize(()=> {
                this.loading = false;
            })
        )
        .subscribe(
            (resp) => {

                console.log(resp);

                const setform = {
                    nome: resp.funcionario.nome,
                    nacionalidade: resp.funcionario.nacionalidade,
                    genero: resp.funcionario.genero,
                    data_nascimento: resp.funcionario.data_nascimento,
                    nr_bi: resp.funcionario.nr_bi,
                    email: resp.email,
                    imagem: '',
                    morada: resp.funcionario.morada,
                    contactos: resp.funcionario.contactos
                };

                localStorage.setItem('funcionario', JSON.stringify(resp.funcionario));

                this.formcontactos = resp.funcionario.contactos;
                function firstInObject(obj){ for (var key in obj) return obj[key];  }
                this.firstContacto = firstInObject(this.formcontactos);
                this.usuario = resp;
                
                this.shareconta.actualiza.next(true);
                
                this.usuarioPhoto = this.apiPath+"/uploads/funcionarios/"+resp.funcionario.imagem;
                this.usuarioPhotoEdit = this.apiPath+"/uploads/funcionarios/"+resp.funcionario.imagem;
                this.formgroup.patchValue(setform);


            }

        )

    }

    

    update() {

        const dados = {

            nome: this.formgroup.get('nome').value,
            nacionalidade: this.formgroup.get('nacionalidade').value,
            genero: this.formgroup.get('genero').value,
            data_nascimento: this.formgroup.get('data_nascimento').value,
            nr_bi: this.formgroup.get('nr_bi').value,
            imagem: this.fileData,
            usuario_id: this.usuario.id,
            morada: {
                rua: this.formgroup.get('morada').get('rua').value,
                bairro: this.formgroup.get('morada').get('bairro').value,
                numero_casa: this.formgroup.get('morada').get('numero_casa').value,
                municipio_id: this.formgroup.get('morada').get('municipio_id').value
            },
            contactos: this.formgroup.get('contactos').value,
        };

        this.usuarioService.update(+this.usuario.funcionario.id, dados).subscribe(
            (res) => {
                this.getUser();
                this.serviceMessage.swalCustom('Sucesso', "Os seus dados foram actualizados", 1000, true);
                this.msg =true;

            },
            (error) => {
                console.log(error);
            }
        );


    }

}
