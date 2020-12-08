import { environment } from './../../../../environments/environment';
import { EscalaService } from './../../../services/escala.service';
import { Component, OnInit} from '@angular/core';
import { ClimaObject } from 'src/app/models/clima-object';
import { finalize } from 'rxjs/internal/operators/finalize';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {



  loading = true;
  public enderecoIMG: string = environment.IMGS;
  funcionarioEscala: any
  motorista: any
  climaObject: ClimaObject;
  active: string;
  mensagem = "Carregando escala do dia"

  constructor(
    private escalaService: EscalaService) { }

  ngOnInit(){

    // busca a esca do funcionario escalado hoje
    this.escalaService.getEscalahoje()
    .pipe(
      finalize(()=> {
        this.loading = false;
      })
    )
    .subscribe(
      (res) => {

        this.funcionarioEscala = res['data']['funcionario_escala'];
        this.motorista = this.funcionarioEscala[0];
        this.active = this.motorista.id;
      }
    );

  }
  mudarMotorista(motorista: any): void {
        this.motorista = motorista;
        this.active = motorista.id;
        console.log(this.active);

  }
}
