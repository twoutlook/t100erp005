/* 
================================================================================
檔案代號:oobm_t
檔案名稱:單據流程設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oobm_t
(
oobment       number(5)      ,/* 企業編號 */
oobm001       varchar2(10)      ,/* 流程編號 */
oobm002       varchar2(5)      ,/* 進銷存單據別參照表 */
oobm003       varchar2(5)      ,/* 財務單據別參照表 */
oobmownid       varchar2(20)      ,/* 資料所有者 */
oobmowndp       varchar2(10)      ,/* 資料所屬部門 */
oobmcrtid       varchar2(20)      ,/* 資料建立者 */
oobmcrtdp       varchar2(10)      ,/* 資料建立部門 */
oobmcrtdt       timestamp(0)      ,/* 資料創建日 */
oobmmodid       varchar2(20)      ,/* 資料修改者 */
oobmmoddt       timestamp(0)      ,/* 最近修改日 */
oobmcnfid       varchar2(20)      ,/* 資料確認者 */
oobmcnfdt       timestamp(0)      ,/* 資料確認日 */
oobmstus       varchar2(10)      ,/* 狀態碼 */
oobmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobm_t add constraint oobm_pk primary key (oobment,oobm001) enable validate;

create unique index oobm_pk on oobm_t (oobment,oobm001);

grant select on oobm_t to tiptop;
grant update on oobm_t to tiptop;
grant delete on oobm_t to tiptop;
grant insert on oobm_t to tiptop;

exit;
