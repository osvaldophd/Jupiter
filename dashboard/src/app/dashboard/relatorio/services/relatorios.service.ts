import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { Viagens, Motoristas, Relatorio, serchParams, ResponseRelatorios }  from '../Models/relatorio.model'
import { environment } from 'src/environments/environment';
@Injectable({
  providedIn: 'root'
})
export class RelatoriosService {

  api = environment.API;


  relatorioData = {

    data: {
      motoristas: [
        {
          name: 'António Simao',
          viagens: 34,
          viagensAnalisadas: 17,
          avalicaoM: 45
        },
        {
          name: 'Filípe Brandão',
          viagens: 24,
          viagensAnalisadas: 8,
          avalicaoM: 45
        },
        {
          name: 'Marcos Simao',
          viagens: 23,
          viagensAnalisadas: 15,
          avalicaoM: 45
        }
      ],
      viagens: [
        {
          name: 'Concluida',
          viagem: 234,

        },
        {
          name: 'Avaliada',
          viagem: 234,

        }
      ]
    },
    status: true,
    numRows: 34

  }

  constructor(private http: HttpClient) { }

  getAll(): Observable<Relatorio> {
    return this.http.get<Relatorio>(`${this.api}dashboard`, {});
  }

  getRelatorios(data: serchParams): Observable<ResponseRelatorios> {
    const params = new HttpParams()
    .set('dataInit', String(data.dataIni))
    .set('dataFin', String(data.dataFin));
    // return this.http.get<any>(`${this.api}`, {params});
    return of(this.relatorioData);
  }



}
