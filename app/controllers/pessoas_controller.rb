class PessoasController < ApplicationController
  before_filter :check_logged

  # GET /pessoas
  # GET /pessoas.json
  def index
    @pessoas = Pessoa.find_by_sql(" select p.codpes, p.nompes, p.dtanas, p.sexpes, p.dtacadpes, c.estciv, v.tipvin, v.codset, v.tiping, v.sitoco, v.dtainisitoco, v.nomabvcla,
                       v.nivgrupvm, v.nomabvfnc, v.tipfnc, v.tipjor, v.tipmer, v.tipcon, n.epflgr, n.numlgr, n.cpllgr, n.codendptl, n.nombro, ep.codema
                       from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                       inner join endpessoa n on p.codpes = n.codpes right join emailpessoa ep on (ep.codpes = p.codpes and stamtr = 'S')
                       where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl in ('A', 'P', 'D') and (staendcrr is null or staendcrr = 'S') and tipend = 'residencial'
                       ORDER BY p.nompes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def gera_relatorio

    busca = ""

    if params[:status] == 'Ativos'

      busca = " select p.codpes, p.nompes, p.dtanas, p.sexpes, p.dtacadpes, c.estciv, v.tipvin, v.codset, v.tiping, v.sitoco, v.dtainisitoco, v.nomabvcla,
                       v.nivgrupvm, v.nomabvfnc, v.tipfnc, v.tipjor, v.tipmer, v.tipcon, n.epflgr, n.numlgr, n.cpllgr, n.codendptl, n.nombro, ep.codema
                       from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                       inner join endpessoa n on p.codpes = n.codpes right join emailpessoa ep on (ep.codpes = p.codpes and stamtr = 'S')
                       where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl in ('A') and (staendcrr is null or staendcrr = 'S') and tipend = 'residencial' "


    elsif params[:status] == 'Inativos'

      busca = " select p.codpes, p.nompes, p.dtanas, p.sexpes, p.dtacadpes, c.estciv, v.tipvin, v.codset, v.tiping, v.sitoco, v.dtainisitoco, v.nomabvcla,
                       v.nivgrupvm, v.nomabvfnc, v.tipfnc, v.tipjor, v.tipmer, v.tipcon, n.epflgr, n.numlgr, n.cpllgr, n.codendptl, n.nombro, ep.codema
                       from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                       inner join endpessoa n on p.codpes = n.codpes right join emailpessoa ep on (ep.codpes = p.codpes and stamtr = 'S')
                       where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl in ('P') and (staendcrr is null or staendcrr = 'S') and tipend = 'residencial' "


    elsif params[:status] == 'Todos'

      busca = " select p.codpes, p.nompes, p.dtanas, p.sexpes, p.dtacadpes, c.estciv, v.tipvin, v.codset, v.tiping, v.sitoco, v.dtainisitoco, v.nomabvcla,
                       v.nivgrupvm, v.nomabvfnc, v.tipfnc, v.tipjor, v.tipmer, v.tipcon, n.epflgr, n.numlgr, n.cpllgr, n.codendptl, n.nombro, ep.codema
                       from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                       inner join endpessoa n on p.codpes = n.codpes right join emailpessoa ep on (ep.codpes = p.codpes and stamtr = 'S')
                       where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl in ('A', 'P', 'D') and (staendcrr is null or staendcrr = 'S') and tipend = 'residencial' "
    end

    if params[:sexo] != ''

      busca = busca + "  and p.sexpes = '" + params[:sexo] + "'"
    end

    if params[:estadocivil] != ''
      busca = busca + "  and c.estciv = '" + params[:estadocivil] + "'"
    end

    if params[:cargo] != ''
      busca = busca + "  and v.nomabvcla = '" + params[:cargo] + "'"
    end

    if params[:jornada] != ''
      busca = busca + "  and v.tipjor = '" + params[:jornada] + "'"
    end

    if params[:regime] != ''
      busca = busca + "  and v.tipcon = '" + params[:regime] + "'"
    end

    busca = busca + " ORDER BY p.nompes "

    session[:buscagerada] = busca

    @pessoas = Pessoa.find_by_sql(busca)

  end

  def gera_relatorioex

    @pessoas = Pessoa.find_by_sql(session[:buscagerada])

    respond_to do |format|
      format.html
      format.xlsx
    end

  end


  def escolhe_relatorio

    @estadocivil = Pessoa.find_by_sql("select distinct c.estciv from pessoa p inner join complpessoa c on p.codpes = c.codpes where estciv is not null ")
    @cargo = Pessoa.find_by_sql(" select distinct v.nomabvcla from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes where nomabvcla is not null ")
    @jornada = Pessoa.find_by_sql(" select distinct v.tipjor from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes where tipjor is not null ")
    @regime = Pessoa.find_by_sql(" select distinct v.tipcon from pessoa p inner join complpessoa c on p.codpes = c.codpes inner join vinculopessoausp v on p.codpes = v.codpes where tipcon is not null ")


  end

  def titulos

    @titulos = Pessoa.find_by_sql(" select p.nompes, t.* from pessoa P inner join docente D on P.codpes = D.codpes inner join titulopes t on D.codpes = t.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                                  where v.codfusclgund = 42 and sitatl = 'A' order by nompes, numseqtitpes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def titulosfunc

    @titulos = Pessoa.find_by_sql(" select p.nompes, t.* from pessoa P inner join titulopes t on p.codpes = t.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                              where v.codfusclgund = 42 and sitatl = 'A' and v.tipfnc not in ('Docente') order by nompes, numseqtitpes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def profissional
    @profissional = Pessoa.find_by_sql(" select p.nompes, h.* from histpes h inner join pessoa p on h.codpes = p.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                                      where v.codfusclgund = 42 and v.tipvin in ('DOCENTE', 'SERVIDOR') and sitatl = 'A' ORDER BY p.nompes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def historico

    @historico = Pessoa.find_by_sql(" select p.codpes, h.nompes, h.dtainihstpes, h.dtafimhstpes, h.tipdocidf, h.sexpes, h.numdocidf, h.dtaexdidf, h.sglorgexdidf, h.sglest
                                      from histpessoa h inner join pessoa p on h.codpes = p.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                                      where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl = 'A' ORDER BY p.nompes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def colegiados

    @colegiados = Pessoa.find_by_sql(" select distinct p.codpes, p.nompes, c.codclg, c.sglclg, c.tipfncclg, c.dtainimdt, c.dtafimmdt, col.tipclg
                                     from pessoa p inner join participantecoleg c on c.codpes = p.codpes inner join colegiado col on (col.codclg = c.codclg and col.sglclg = c.sglclg)
                                     inner join vinculopessoausp v on p.codpes = v.codpes
                                     where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl = 'A' and col.codundrsp = 42
                                     ORDER BY p.nompes")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  def suplencias
    @suplencias = Pessoa.find_by_sql(" select p.codpes, p.nompes, c.codclgttu, c.sglclgttu, c.tipfncclgttu, c.tipfncclgsup, c.dtainimdtsup
                                      from pessoa p inner join participantecolegsupl c on c.codpesttu = p.codpes
                                      inner join colegiado col on (col.codclg = c.codclgsup and col.sglclg = c.sglclgsup)
                                      inner join vinculopessoausp v on p.codpes = v.codpes
                                      where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl = 'A' ORDER BY p.nompes ")
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

=begin
  def validacao
    @validacao = Pessoa.find_by_sql(" select p.codpes, p.nompes, t.dtaocoval, t.tipvaltit, t.dtamancpg, t.staaprcpg, t.dtamancog, t.staaprcog, t.obssitrco
                                      from validacaotitulo t inner join pessoa p on t.codpes = p.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                                      where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl = 'A' ORDER BY p.nompes, t.numseqtitpes ")


  end
=end

  def chefias
    @chefias = Pessoa.find_by_sql(" select p.nompes, p.codpes, t.tipvin, t.dtainidsg, t.dtafimdsg, t.nomabvfncetr, t.nomfncetr, t.tipdsg, t.tipsbnogn
                                  from vincsatdesignacao t inner join pessoa p on t.codpes = p.codpes inner join vinculopessoausp v on p.codpes = v.codpes
                                  where v.codfusclgund = 42 and v.tipvin in ('SERVIDOR') and sitatl = 'A' ORDER BY p.nompes ")

    respond_to do |format|
      format.html
      format.xlsx
    end

  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pessoa_params
      params.require(:pessoa).permit(:codpes, :nompes)
    end
end
