import { environment } from '../../../../environments/environment';
import { Component, OnInit } from '@angular/core';
import { MotoristaService } from 'src/app/services/motorista.service';
import { FormGroup, FormControl } from '@angular/forms';
import { FuncionarioService } from '../../services/funcionario.service';

@Component({
  selector: 'app-motoristas',
  templateUrl: './motoristas.component.html',
  styleUrls: ['./motoristas.component.css']
})
export class MotoristasComponent implements OnInit {
  motoristaAll: Array<any>;
  // formulario para buscar escala por data
  buscaForm = new FormGroup({
    nomeBusca: new FormControl(''),
  });
  motorista: any[] = [];
  public enderecoIMG: string = environment.IMGS;
  motoristaAux: any;
  slideConfig = {"slidesToShow": 4, "slidesToScroll": 4};

  constructor(private motoristaService: FuncionarioService) { }

  ngOnInit() {
    // busca a esca todos os funcionario

    this.motoristaService.getMotorista().subscribe(
      (res) => {
        console.log(res);
        this.motoristaAll = res['data']['funcionarios'];
        this.motoristaAux = res['data']['funcionarios'];
      }
    );
  }

  buscarMotorista(): void {
    this.motorista = [];
    this.motoristaAux.map((item) => {
      if (item.nome === this.buscaForm.value['nomeBusca'])
        this.motorista.push(item)
    });
    this.motoristaAll = this.motorista;
  }

  removeSlide() {
    this.motoristaAll.length = this.motoristaAll.length - 1;
  }
  
  slickInit(e) {
    console.log('slick initialized');
  }
  
  breakpoint(e) {
    console.log('breakpoint');
  }
  
  afterChange(e) {
    console.log('afterChange');
  }
  
  beforeChange(e) {
    console.log('beforeChange');
  }

}
