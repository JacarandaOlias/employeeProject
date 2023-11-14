package es.jacaranda;

import org.apache.commons.codec.digest.DigestUtils;

public class pruebaMd5 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String cadenaEncriptada = DigestUtils.md5Hex("inma");
		System.out.println(cadenaEncriptada);

	}

}
