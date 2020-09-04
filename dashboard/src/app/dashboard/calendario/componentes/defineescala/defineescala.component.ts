import { Component, OnInit } from '@angular/core';
import { FuncionariosService } from 'src/app/dashboard/funcionarios/services/funcionarios.service';
import { $ } from 'protractor';
import { CalendarioService } from 'src/app/services/calendario.service';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { SwalService } from 'src/app/services/swal.service';
import { analyzeAndValidateNgModules } from '@angular/compiler';
import { environment } from 'src/environments/environment';
import { setTimeout } from 'timers';
import { finalize } from 'rxjs/operators';

@Component({
  selector: 'app-defineescala',
  templateUrl: './defineescala.component.html',
  styleUrls: ['./defineescala.component.css']
})
export class DefineescalaComponent implements OnInit {

  funcionarios: any;
  fucionariosData: Array<any>;
  escalados: Array<any> = [];
  grupoElescalados: Array<any> = [];
  fEscalados: Array<any> = [];
  arrayEscalados: Array<any> = [];
  f_data: Array<number> = [];
  formulario: FormGroup;
  nGrupos: number;
  api_path = environment.API_PATH;
  loading: boolean = true;


  resultadoPesquisa: Array<any> = [];
  pesquisaOn: boolean = false;

  constructor(
    private funcionariosService: FuncionariosService,
    private calendaioService: CalendarioService,
    private fb: FormBuilder,
    private swal: SwalService
  ) {
    this.formulario = fb.group({
      mes: ['', Validators.required],
      intervalo: ['', Validators.required]

    })


  }

  get mes() {
    return this.formulario.get('mes');
  }

  get intervalo() { return this.formulario.get('intervalo') }


  gruposEscalados() {

    this.grupoElescalados = [];

    var itens: Array<any> = [];
    const totalItens = this.escalados.length;
    const total = (totalItens / this.nGrupos);
    var i = 0;

    for (var j = 0; j < total; j++) {

      for (var k = 0; k < this.nGrupos; k++) {
        itens.push(this.escalados[i]);
        i++;
        if (i === this.escalados.length) break;
      }

      this.grupoElescalados.push({ users: itens, grupo: (j + 1) });
      itens = [];

    }



  }


  pesquisar(data) {

    this.resultadoPesquisa = [];
    this.pesquisaOn = false;

    if (data != '') {
      this.pesquisaOn = true;

      this.funcionarios.filter(dados => {
        const nome: string = this.cleanString(dados.nome);
        if (nome.includes(this.cleanString(data))) {
          this.resultadoPesquisa.push(dados);
        }

      });
    }

  }


  cleanString(text): string {

    text = text.toLowerCase();
    text = text.replace(new RegExp('[ÁÀÂÃ]', 'gi'), 'a');
    text = text.replace(new RegExp('[ÉÈÊ]', 'gi'), 'e');
    text = text.replace(new RegExp('[ÍÌÎ]', 'gi'), 'i');
    text = text.replace(new RegExp('[ÓÒÔÕ]', 'gi'), 'o');
    text = text.replace(new RegExp('[ÚÙÛ]', 'gi'), 'u');
    text = text.replace(new RegExp('[Ç]', 'gi'), 'c');
    return text;
  }

  ngOnInit() {

    this.funcionariosService.getAllMotoristas().pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).subscribe(
      (resp) => {

        this.funcionarios = resp;
        this.funcionarios = this.funcionarios.data.funcionarios;
        var resultado: Array<any> = [];

        Object.values(this.funcionarios).forEach(elemento => {
          elemento['checked'] = false;
          resultado.push(elemento);
        })

        this.funcionarios = resultado;
        this.fucionariosData = this.funcionarios;
      }
    )
  }

  addfunctionarios() {
  }


  numeroGrupo(item) {
    this.nGrupos = item;
    this.gruposEscalados();
  }

  create() {

    if (this.escalados.length <= 0) {
      this.swal.swalTitleText('Erro! Cadastro de Escala', 'Por favor,  seleccione pelo menos um motorista para a escala', 'error');
      return false;
    }

    const data = {
      funcionarios: this.f_data,
      ano: null,
      mes_id: this.formulario.value.mes,
      motoristas_por_dia: this.formulario.value.intervalo
    };


    this.calendaioService.create(data).subscribe(
      (resp: any) => {

        if (resp.status === true) {
          this.swal.swalCustom('Escala Mensal', `Foi gerada uma escala mensal com ${data.motoristas_por_dia} motoriasta/dia`, 2000, true);
        } else {
          this.swal.swalTitleText(
            'Cadastro de Escala',
            `Não foi possível gerar a escala mensal!`, 'error');
        }
      }
    )

  }

  /* Methodo usado para selecionar os funcionarios a serem incluidos na escala */
  adicionarFuncionario(data) {


    if (data.target.checked) {

      this.funcionarios.forEach(dados => {
        if (dados.id == data.target.value) {
          dados.checked = true;
          this.escalados.push(dados);
          this.f_data.push(data.target.value);
        }

      });

    } else {

      this.escalados.forEach(dados => {
        if (dados.id == data.target.value) {
          const key = this.escalados.indexOf(dados);
          this.escalados.splice(key, 1);

          const key2 = this.funcionarios.indexOf(dados);
          this.funcionarios[key2].checked = false;

          const keyid = this.f_data.indexOf(data.target.value);
          this.f_data.splice(keyid, 1);

        }

      });


    }

    this.gruposEscalados();

  }




}
