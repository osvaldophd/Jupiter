import { environment } from 'src/environments/environment';
import { Component, OnInit } from '@angular/core';
import { FuncionarioService } from '../../services/funcionario.service';
import { finalize } from 'rxjs/operators';


@Component({
  selector: 'app-vans',
  templateUrl: './vans.component.html',
  styleUrls: ['./vans.component.css']
})
export class VansComponent implements OnInit {

  vans: any;
  vanSelecionado: any;
  enderecoIMG: string = environment.IMGS;
  slideConfig = {"slidesToShow": 4, "slidesToScroll": 4};
  loading: boolean = true;
  mensagem: string = "Carregando Vans";

  constructor(private funcionarioService: FuncionarioService) { }

  ngOnInit() {
    this.funcionarioService.getVans()
    .pipe(
      finalize(()=> {
        this.loading = false;
      })
    ).
    subscribe(
      (res) => {
        this.vans = res['data']['vans'];
        console.log(res);
      }
    );
  }

  removeSlide() {
    this.vans.length = this.vans.length - 1;
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
