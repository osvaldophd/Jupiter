import { environment } from './../../../../environments/environment';
import { EscalaService } from './../../../services/escala.service';
import { Component, OnInit} from '@angular/core';
import { ClimaObject } from 'src/app/models/clima-object';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {



  loading = false;
  public enderecoIMG: string = environment.IMGS;
  funcionarioEscala: any
  motorista: any
  climaObject: ClimaObject;
  active: string;

  constructor(
    private escalaService: EscalaService) { }

  ngOnInit(){
    this.loading = true;
    // busca a esca do funcionario escalado hoje
    this.escalaService.getEscalahoje().subscribe(
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
