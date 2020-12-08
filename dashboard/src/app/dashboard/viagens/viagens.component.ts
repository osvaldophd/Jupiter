import { Subscription } from 'rxjs/internal/Subscription';
import { MessageService } from './../../shared/services/mensage.service';
import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';
import { TokenService } from 'src/app/services/token.service';
import { ViagemService } from './services/viagem.service';
import { Viagem } from './viagem.model';
import { environment } from 'src/environments/environment';
import { FormBuilder, FormGroup } from '@angular/forms';
import { SwalService } from './../../services/swal.service';
import { Vans } from './../../models/vans.model';
import { VansService } from './../vans/services/vans.service';
import { finalize, filter, map } from 'rxjs/operators';


@Component({
  selector: 'app-viagens',
  templateUrl: './viagens.component.html',
  styleUrls: ['./viagens.component.css']
})
export class ViagensComponent implements OnInit {

  searchForm: FormGroup;

  filtros = {
    nomeMotorista: true,
    nomeUsuario: true,
    idVan: false,
    latitude: false,
    longitude: false,
    dataInicio: false,
    dataFim: false,
    data: false
  };

  vans: Vans;

  userFilter = [];

  serachStatus = false;
  resultPesquisa: boolean = false;
  count: number;

  viagens: Viagem[];
  api = environment.API_PATH;
  loading: boolean = true;


  constructor(
    private formBuilder: FormBuilder,
    private viagemService: ViagemService,
    private messageService: MessageService,
    private vanService: VansService
  ) { }

  ngOnInit() {
    this.vanService.getAll().pipe(
      finalize(()=> {
        this.loading = false;
      })
    )
    .subscribe( (res ) => {
      this.vans = res.data.vans;

    });

    this.userFilter = ['nomeMotorista', 'nomeUsuario'];

    this.searchForm = this.formBuilder.group({
      nomeMotorista: '',
      nomeUsuario: '',
      idVan: '',
      data: '',
      dataInicio: '',
      dataFim: '',
    });

    this.viagemService.getAll().subscribe((res: any) => {
      this.viagens = res.data.viagens;
    });
  }

  setFilter({name}) {
      if (this.filtros[name]) {
        this.filtros[name] = false;
        this.userFilter.find((filter, i) => {
          if (filter === name) {
            this.userFilter.splice(i, 1);
          }
        });
        return;
      }

      this.filtros[name] = true;
      this.userFilter = [...this.userFilter, name];
      return ;
  }


  search(v) {
    const query = this.userFilter.reduce((p, c) =>  `${c}=${v[c]} &` + `${p}=${v[p]} &` );
      this.loading = true;
    this.viagemService.getQuery(query).pipe(
      finalize(()=> {
        this.loading = false;

      })
    ).subscribe((res: any) => {
      this.serachStatus = true;
      this.count = res.data.viagens.length;
      if (this.count == 0) {
        this.viagens = null;
        this.resultPesquisa = false;
        this.messageService.swalSeaech();
      }

      if (this.count != 0 ) {

        this.viagens = res.data.viagens;
        this.resultPesquisa = true;

      }

    });

  }

  comentario(idViagem: number){
     const comentario = this.viagens.map(dados=>dados).find(dados=>dados.id == idViagem)
     this.messageService.mensage(comentario['usuario'].nome.toUpperCase()+' comentou', comentario.comentario, 'info');
  }

}
