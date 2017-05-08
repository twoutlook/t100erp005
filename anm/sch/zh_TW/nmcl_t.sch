/* 
================================================================================
檔案代號:nmcl_t
檔案名稱:應付匯款來源明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmcl_t
(
nmclent       number(5)      ,/* 企業編號 */
nmclcomp       varchar2(10)      ,/* 法人 */
nmcldocno       varchar2(20)      ,/* 單據號碼 */
nmclseq       number(10,0)      ,/* 序號 */
nmclorga       varchar2(10)      ,/* 來源組織 */
nmcl001       varchar2(20)      ,/* 請款單號 */
nmcl002       number(10,0)      ,/* 項次 */
nmcl003       varchar2(24)      ,/* 對方會科 */
nmcl103       number(20,6)      ,/* 請款原幣金額 */
nmcl113       number(20,6)      ,/* 請款本幣金額 */
nmcl121       number(20,10)      ,/* 本位幣二匯率 */
nmcl123       number(20,6)      ,/* 本位幣二金額 */
nmcl131       number(20,10)      ,/* 本位幣三匯率 */
nmcl133       number(20,6)      ,/* 本位幣三金額 */
nmclud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmclud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmclud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmclud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmclud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmclud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmclud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmclud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmclud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmclud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmclud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmclud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmclud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmclud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmclud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmclud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmclud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmclud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmclud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmclud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmclud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmclud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmclud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmclud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmclud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmclud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmclud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmclud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmclud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmclud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcl_t add constraint nmcl_pk primary key (nmclent,nmclcomp,nmcldocno,nmclseq) enable validate;

create unique index nmcl_pk on nmcl_t (nmclent,nmclcomp,nmcldocno,nmclseq);

grant select on nmcl_t to tiptop;
grant update on nmcl_t to tiptop;
grant delete on nmcl_t to tiptop;
grant insert on nmcl_t to tiptop;

exit;
