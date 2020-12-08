import { Usuario } from './../../models/modelfuncionario';
import { Component, OnInit } from '@angular/core';
import { FuncionariosService } from '../../services/funcionarios.service';
import { Funcionarios } from 'src/app/models/funcionarios.model';
import { Funcionario } from '../../models/funcionario.model';
import { environment } from 'src/environments/environment';
import { SwalService } from 'src/app/services/swal.service';
import { finalize } from 'rxjs/operators';
import { PaginatorService } from 'src/app/shared/services/paginator.service';
import { Profile } from 'src/app/dashboard/profile/profile.modul';
import { ProfileService } from 'src/app/dashboard/profile/services/profile.service';

@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.css']
})
export class ListComponent implements OnInit {
  // tslint:disable-next-line: no-unused-expression

  dados: any;
  api_path = environment.API_PATH;
  pesquisaOn: boolean = false;
  pesquisaR: Array<any> = [];
  loading: boolean = true;
  paginator: Array<any> = [];
  pageData: any;
  pageActive: number = 1;
  me: Profile;

  constructor(
    private funcionarios: FuncionariosService,
    private swalService: SwalService,
    private paginatorService: PaginatorService,
    private profileService: ProfileService
  ) {

  }

  ngOnInit() {
    this.getFuncionarios();

    this.profileService.getAll()
      .subscribe((res: any) => {
        this.me = res;
      });
  }

  getPage(page) {
    this.pageActive = (page) ? page : 1;
    this.paginatorService.setPage(page);
    this.pageData = this.paginatorService.getData();
    this.paginator = this.paginatorService.getPages();
  }

  getFuncionarios() {

    this.funcionarios.getAll().pipe(
      finalize(() => {
        this.loading = false;
      })
    ).subscribe((res) => {
      this.dados = res;
      this.dados = this.dados.data.funcionarios;
      this.pageData = this.paginatorService.getPaginator(this.dados);
      this.paginator = this.paginatorService.getPages();
    },
      (error) => {

      }
    )
  }

  getFuncionarioId(id: number) {
    this.funcionarios.getById(id).subscribe(
      (response: any) => {
        this.dados = response;
      },
      (error) => { }
    )
  }

  pesquisar(pesquisa) {
    this.pesquisaOn = false;
    this.pesquisaR = [];

    if (pesquisa != null) {


      const funcionarios: Array<any> = this.dados
      funcionarios.find((funcionario) => {
        if (this.cleanString(funcionario.nome).includes(this.cleanString(pesquisa))) {
          this.pesquisaR.push(funcionario);
        }

      });

      this.paginatorService.setPage(1);
      this.pageData = this.paginatorService.getPaginator(this.pesquisaR);
      this.paginator = this.paginatorService.getPages();
      this.pesquisaOn = true;

    } else {

      this.paginatorService.setData(this.dados);
      this.getPage(1);
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

  delete(dados: any) {

    const handlerCallback = () => {
      this.funcionarios.deteteFnc(+dados.id)
        .subscribe((res) => {

          this.swalService.swalTitleText('Sucesso', `O colaborador <strong> ${dados.nome} <strong> foi eliminado!`, 'success');
          this.getFuncionarios();
          if (this.pesquisaOn) {
            const pos = this.pesquisaR.indexOf(dados);
            this.pesquisaR.splice(pos, 1);
          }
        });
    };



    this.swalService.swalConfirmation(
      'Eliminar Colaborador',
      `Deseja eliminar o colaborador ${dados.nome}?`,
      'warning',
      `Sim, eliminar`,
      handlerCallback
    );
  }
  userLogado(user: Usuario):boolean{
    if (this.me.email === user.email) {
      return true;
    }
    return false;
  }
}
