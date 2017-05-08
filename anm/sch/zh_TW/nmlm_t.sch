/* 
================================================================================
檔案代號:nmlm_t
檔案名稱:銀行帳戶部門設限檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmlm_t
(
nmlment       number(5)      ,/* 企業代碼 */
nmlmownid       varchar2(20)      ,/* 資料所有者 */
nmlmowndp       varchar2(10)      ,/* 資料所屬部門 */
nmlmcrtid       varchar2(20)      ,/* 資料建立者 */
nmlmcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmlmcrtdt       timestamp(0)      ,/* 資料創建日 */
nmlmmodid       varchar2(20)      ,/* 資料修改者 */
nmlmmoddt       timestamp(0)      ,/* 最近修改日 */
nmlmstus       varchar2(10)      ,/* 狀態碼 */
nmlmcomp       varchar2(10)      ,/* 法人 */
nmlmsite       varchar2(10)      ,/* 營運據點 */
nmlm001       varchar2(10)      ,/* 交易帳戶編號 */
nmlm002       varchar2(10)      ,/* 部門編號 */
nmlmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmlmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmlmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmlmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmlmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmlmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmlmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmlmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmlmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmlmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmlmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmlmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmlmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmlmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmlmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmlmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmlmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmlmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmlmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmlmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmlmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmlmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmlmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmlmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmlmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmlmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmlmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmlmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmlmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmlmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmlm_t add constraint nmlm_pk primary key (nmlment,nmlm001,nmlm002) enable validate;

create unique index nmlm_pk on nmlm_t (nmlment,nmlm001,nmlm002);

grant select on nmlm_t to tiptop;
grant update on nmlm_t to tiptop;
grant delete on nmlm_t to tiptop;
grant insert on nmlm_t to tiptop;

exit;
