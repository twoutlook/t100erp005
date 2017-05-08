/* 
================================================================================
檔案代號:nmed_t
檔案名稱:應付匯款來源單身明細(流通)
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmed_t
(
nmedent       number(5)      ,/* 企業編碼 */
nmedcomp       varchar2(10)      ,/* 法人 */
nmedsite       varchar2(10)      ,/* 資金中心 */
nmeddocno       varchar2(20)      ,/* 單據單號 */
nmedseq       number(10,0)      ,/* 項次 */
nmedorga       varchar2(10)      ,/* 來源組織 */
nmed001       varchar2(20)      ,/* 來源作業 */
nmed002       varchar2(10)      ,/* 付款類型 */
nmed003       varchar2(20)      ,/* 請款單號 */
nmed004       number(10,0)      ,/* 項次 */
nmed005       number(10,0)      ,/* 帳期 */
nmed006       varchar2(10)      ,/* 付款對象 */
nmed007       varchar2(10)      ,/* 款別代碼 */
nmed008       varchar2(20)      ,/* 帳戶票卷號碼 */
nmed009       varchar2(10)      ,/* 現金變動碼 */
nmed010       varchar2(10)      ,/* 銀行存提碼 */
nmed011       varchar2(24)      ,/* 對方會科 */
nmed012       number(20,6)      ,/* 請款原幣 */
nmed013       number(20,6)      ,/* 請款本幣 */
nmed014       number(20,10)      ,/* 匯率 */
nmed100       number(20,10)      ,/* 本位幣二匯率 */
nmed101       number(20,6)      ,/* 本位幣二金額 */
nmed110       number(20,10)      ,/* 本位幣三匯率 */
nmed111       number(20,6)      ,/* 本位幣三金額 */
nmedud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmedud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmedud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmedud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmedud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmedud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmedud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmedud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmedud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmedud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmedud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmedud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmedud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmedud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmedud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmedud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmedud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmedud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmedud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmedud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmedud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmedud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmedud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmedud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmedud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmedud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmedud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmedud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmedud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmedud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmed_t add constraint nmed_pk primary key (nmedent,nmedcomp,nmeddocno,nmedseq) enable validate;

create unique index nmed_pk on nmed_t (nmedent,nmedcomp,nmeddocno,nmedseq);

grant select on nmed_t to tiptop;
grant update on nmed_t to tiptop;
grant delete on nmed_t to tiptop;
grant insert on nmed_t to tiptop;

exit;
