/* 
================================================================================
檔案代號:nmec_t
檔案名稱:待結算卡差異明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmec_t
(
nmecent       number(5)      ,/* 企業編碼 */
nmeccomp       varchar2(10)      ,/* 法人 */
nmecsite       varchar2(10)      ,/* 營運據點 */
nmecdocno       varchar2(20)      ,/* 單據單號 */
nmecseq       number(10,0)      ,/* 項次 */
nmec001       varchar2(20)      ,/* 系統參考號 */
nmec002       varchar2(40)      ,/* 活動名稱 */
nmec003       varchar2(40)      ,/* 終端編號 */
nmec004       varchar2(40)      ,/* 銀行賬號 */
nmec005       varchar2(40)      ,/* 髮卡銀行 */
nmec006       number(20,6)      ,/* 原交易金額 */
nmec007       number(20,6)      ,/* 實際交易金額 */
nmec008       number(20,6)      ,/* 銀行卡交易金額 */
nmec009       number(20,6)      ,/* 銀行卡手續費 */
nmec011       number(10)      ,/* 積分類型 */
nmec012       varchar2(20)      ,/* 交易類型 */
nmec013       varchar2(20)      ,/* 補貼機構 */
nmec014       varchar2(10)      ,/* 交易日 */
nmec015       number(20,6)      ,/* 積分交易金額 */
nmec016       number(20,6)      ,/* 積分手續費 */
nmec017       number(20,6)      ,/* 交易手續費 */
nmec018       varchar2(10)      ,/* No Use */
nmec019       varchar2(10)      ,/* No Use */
nmec020       varchar2(10)      ,/* No Use */
nmec021       number(20,6)      ,/* 返點金額 */
nmec022       varchar2(1)      ,/* 對賬否 */
nmec023       varchar2(40)      ,/* No Use */
nmec024       varchar2(20)      ,/* 交易賬戶編碼 */
nmecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmecud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
nmec025       date      ,/* 交易日期 */
nmec026       date      ,/* 對帳日期 */
nmec027       number(20,6)      ,/* 清算金額 */
nmec028       number(20,6)      /* 機構補貼金額 */
);
alter table nmec_t add constraint nmec_pk primary key (nmecent,nmeccomp,nmecdocno,nmecseq) enable validate;

create unique index nmec_pk on nmec_t (nmecent,nmeccomp,nmecdocno,nmecseq);

grant select on nmec_t to tiptop;
grant update on nmec_t to tiptop;
grant delete on nmec_t to tiptop;
grant insert on nmec_t to tiptop;

exit;
