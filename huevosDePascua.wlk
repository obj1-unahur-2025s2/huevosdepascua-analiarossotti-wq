
object huevoRepostero {
    method calorias() = 750

    method esDeChocoBlanco() = true
    method esDeChocoAmargo() = false
    method esDeChocoConLeche() = false
}

object huevoMixto {
    method caloriasChocoLeche() = 400
    method caloriasChocoBlanco() = 500
    method calorias() = self.caloriasChocoLeche() + self.caloriasChocoBlanco()

    method esDeChocoBlanco() = true
    method esDeChocoAmargo() = false
    method esDeChocoConLeche() = true
}
//- ConejoEs de chocolate amargo y tiene diez veces su peso por cada gramo en calorías.
object conejo {
    var peso = 20 
    method peso() = peso
    
    method calorias() = peso * 10

    method cambiarPeso(nuevoPeso) {
        return peso = nuevoPeso
    }
    method esDeChocoBlanco() = false
    method esDeChocoAmargo() = true
    method esDeChocoConLeche() = false
}


/*- Blister de huevitos: Trae un número arbitrario de huevos de chocolate con leche, 
que dan 100 calorías cada uno. Por cada 5 huevos de chocolate con leche se agrega de regalo uno de 
chocolate blanco que tiene 150 calorías. (ayuda: los números entienden el mensaje div(n) para realizar la división entera)
*/
object blisterDeHuevitos {
    var cantidadHuevitos = 14
    var calorias = cantidadHuevitos * 100
    var huevitosBlancosExtra = 0
    
    method calorias() = calorias + self.caloriasChocoBlanco()
    method caloriasChocoBlanco() = huevitosBlancosExtra * 150
    method cantidadChocoBlanco() {
        if(cantidadHuevitos > 5){
            huevitosBlancosExtra = cantidadHuevitos.div(5)
        }
        return huevitosBlancosExtra
    }
    
    method cantidadHuevitos () = cantidadHuevitos
    method cambiarCantHuevitos(cantidad){
        return cantidadHuevitos = cantidad
    }
    method esDeChocoBlanco() = true
    method esDeChocoAmargo() = false
    method esDeChocoConLeche() = true
}

object matrioshka {
    const huevoEnSuInterior = conejo
    var decoracion = flor
    var caloriasDecoracion = 0
    var cantidadPetalos = 7
    const flor = 100
    const arbol = 150
    
    method huevoEnSuInterior() = huevoEnSuInterior
    method calorias() = 3000 + huevoEnSuInterior.calorias() + caloriasDecoracion + blisterDeHuevitos.calorias()
    method arbol() = arbol
    method flor() = flor
    
    method cambiarDecoracionAArbol(){
        decoracion = arbol
    }

    method cambiarDecoracionAFlor(){
        decoracion = flor
    }
    method cantidadPetalos() = cantidadPetalos
    method cantidadPetalos(nueva) {
        cantidadPetalos = nueva
    }

    method caloriasDecoracion() = caloriasDecoracion
    method cantCaloriasDecoracion() {
        if (decoracion == self.flor()) {
           caloriasDecoracion = cantidadPetalos * flor
        } else {caloriasDecoracion = arbol}

    }

    method esDeChocoBlanco() = blisterDeHuevitos.esDeChocoBlanco() 
    method esDeChocoAmargo() = true
    method esDeChocoConLeche() = false
}

object caceria {
    const huevosDelJuego = [matrioshka, huevoRepostero, conejo, huevoMixto]
    //matrioshka, huevoRepostero, conejo, huevoMixto
    var huevosABuscar = []
    var huevosEncontrados = []
    var huevosPorEncontrarChocoBlanco = []

    method huevosDelJuego() = huevosDelJuego
    method huevosABuscar() = huevosABuscar
    method huevosEncontrados() = huevosEncontrados
    method huevosPorEncontrarChocoBlanco() = huevosABuscar.filter({h => h.esDeChocoBlanco()})

    method aunNoFueEncontrado(unHuevo) {
        huevosABuscar.contains(unHuevo)
    }

    method encontrarUnHuevo(unChico, unHuevo) {
        if(!huevosABuscar.isEmpty()) {
            unChico.comer(unHuevo) //lo agrega a su lista de huevos comidos
            huevosEncontrados.add(unHuevo)
            huevosABuscar.remove(unHuevo)
        }
    }
    
    method encontrarPrimerHuevo(unChico) {
            unChico.comer(huevosABuscar.first()) //lo agrega a su lista de huevos comidos
            huevosEncontrados.add(huevosABuscar.first())
            huevosABuscar.remove(huevosABuscar.first())
    }
    method encontrarTodosLosHuevosRestantes(unChico){
        if(!huevosABuscar.isEmpty()) {
            huevosABuscar.forEach({h => unChico.comer(h)})
            huevosEncontrados.addAll(huevosABuscar)
            huevosABuscar.clear()
        }
    }

    method huevoDeMayorcalorias() {
        return huevosABuscar.max({h => h.calorias()})
    }
}

object ana {
    var huevosConsumidos = []

    method comer(unHuevo) = huevosConsumidos.add(unHuevo)
    method huevosConsumidos() = huevosConsumidos
    method estaEnfermo() = self.comioMasDe5000() || self.comioDeChocoBlanco()
    method comioMasDe5000() = huevosConsumidos.sum({h => h.calorias()}) > 5000
    method comioDeChocoBlanco() = huevosConsumidos.any({h => h.esDeChocoBlanco()})
}

object jose {
    var huevosConsumidos = []

    method comer(unHuevo) = huevosConsumidos.add(unHuevo)
    method huevosConsumidos() = huevosConsumidos
    method ultimoHuevoConsumido() = self.huevosConsumidos().last()
    //ultimo huevo comido, ver si es de choco amargo
    method estaEnfermo() = self.ultimoHuevoConsumido().esDeChocoAmargo() 
}

object tito {
    var huevosConsumidos = []

    method comer(unHuevo) = huevosConsumidos.add(unHuevo)
    method huevosConsumidos() = huevosConsumidos
    method estaEnfermo() = false //come de todo, nada lo enferma
}