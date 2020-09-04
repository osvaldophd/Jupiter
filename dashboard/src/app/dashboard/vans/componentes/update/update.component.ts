import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { VansService } from '../../services/vans.service';
import { FormBuilder, FormArray, FormGroup, Validators } from '@angular/forms';
import { CreateVan } from '../../models/createVan.model';
import { MarcasService } from '../../services/marcas.service';
import { ListaMarcas } from '../../models/listaMarcas.model';
import { SwalService } from 'src/app/services/swal.service';
import { environment } from 'src/environments/environment';
import { finalize } from 'rxjs/operators';

@Component({
    selector: 'app-update',
    templateUrl: './update.component.html',
    styleUrls: ['./update.component.css']
})
export class UpdateComponent implements OnInit {

    api_path = environment.API_IMG;

    form: any;
    van: CreateVan;
    listavans: any;
    id: number;
    idmodelo: any;
    listamarcas: any;
    listamodelos: any;
    pegaridmarca: number;
    fileImg: any;
    fileData: any;
    f: any;
    loading: boolean = true;

    mask = {
        matricula: [/[A-Z]/, /[A-Z]/, '-', /\d/, /\d/, '-', /\d/, /\d/, '-', /[A-Z]/, /[A-Z]/],
        telefone: [/[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/, ' ', /[0-9]/, /[0-9]/, /[0-9]/],
        bi: [/[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[0-9]/, /[A-Z]/, /[A-Z]/, /[0-9]/, /[0-9]/, /[0-9]/]
    };

    constructor(
        private vanservice: VansService,
        private route: ActivatedRoute,
        private marcasService: MarcasService,
        private fb: FormBuilder,
        private cd: ChangeDetectorRef,
        private swal: SwalService
    ) {

        this.form = this.fb.group({
            id: [''],
            matricula: [''],
            descricao: [''],
            marca: [''],
            modelo_id: [''],
            ano_quisicao: [''],
            nr_ocupantes: ['', Validators.required],
            imagem: [''],
            modelo: this.fb.group({
                id: [''],
                nome: [''],
                marca_id: [''],
                created_at: [''],
                updated_at: ['']
            }),
            contactos: this.fb.array([
                this.fb.group({
                    contacto: ['', Validators.required]
                })
            ])

        });
        // Fim do form Builder
    }

    ngOnInit() {

        this.id = this.route.snapshot.params.id;
        this.vanservice.getById(+this.id).pipe(
            finalize(() => {
                this.VerMarcas();
            })
        )
            .subscribe(
                (res) => {
                    this.listavans = res;
                    this.listavans = this.listavans.van[0];
                    this.idmodelo = this.listavans.modelo.marca_id;
                    const telefones: Array<any> = this.listavans.contactos || [];
                    this.fileImg = this.api_path + this.listavans.imagem;
                    this.listavans.imagem = null;
                    this.form.patchValue(this.listavans);
                    this.contacto.clear();
                    telefones.forEach(data => {
                        this.contacto.push(
                            this.fb.group({
                                contacto: [data.contacto, Validators.required]
                            })

                        )
                    })

                    

                }
            )

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

    get fv() { return this.form.controls; }

    get contacto() { return this.form.get('contactos') as FormArray; }

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


    VerMarcas() {
        this.marcasService.getAll().subscribe(
            (marcas: ListaMarcas) => {
                this.listamarcas = marcas.data;
                this.listamarcas = this.listamarcas.marcas;
                this.listamarcas = this.listamarcas;
                this.selectMarca(this.idmodelo);
                this.loading = false;
            }
        );
    }

    selectMarca(event) {

        const id = event;
        const modelos = this.listamarcas.filter(model => model.id == id);
        this.listamodelos = modelos[0].modelos;

    }


    update() {


        const dataVan: CreateVan = {
            matricula: this.form.value.matricula,
            descricao: this.form.value.descricao,
            modelo_id: this.form.get('modelo').get('id').value,
            cor_id: 3,
            imagem: this.fileData,
            nr_ocupantes: this.form.get('nr_ocupantes').value,
            contactos: this.form.get('contactos').value
        }

        

        this.vanservice.update(this.id, dataVan)
            .subscribe(
                (res) => {
                    this.swal.swalTitleText('Cadastro com Sucesso', `Dados da van <strong> ${dataVan.matricula} </strong> alterado!`, 'success');
                },
                (error) => {
                    this.swal.swalTitleText('Editar Van ', 'Desculpa, não foi possível Alterar os dados', 'error');
                    
                }
            )


    }

}
