/* 
================================================================================
檔案代號:xmes_t
檔案名稱:銷售估價範本單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmes_t
(
xmesent       number(5)      ,/* 企業編號 */
xmessite       varchar2(10)      ,/* 營運據點 */
xmesdocno       varchar2(20)      ,/* 範本料號 */
xmes001       number(5,0)      ,/* 版次 */
xmesownid       varchar2(20)      ,/* 資料所有者 */
xmesowndp       varchar2(10)      ,/* 資料所屬部門 */
xmescrtid       varchar2(20)      ,/* 資料建立者 */
xmescrtdp       varchar2(10)      ,/* 資料建立部門 */
xmescrtdt       timestamp(0)      ,/* 資料創建日 */
xmesmodid       varchar2(20)      ,/* 資料修改者 */
xmesmoddt       timestamp(0)      ,/* 最近修改日 */
xmesstus       varchar2(10)      ,/* 狀態碼 */
xmesud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmesud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmesud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmesud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmesud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmesud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmesud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmesud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmesud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmesud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmesud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmesud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmesud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmesud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmesud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmesud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmesud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmesud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmesud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmesud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmesud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmesud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmesud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmesud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmesud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmesud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmesud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmesud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmesud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmesud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmes_t add constraint xmes_pk primary key (xmesent,xmessite,xmesdocno,xmes001) enable validate;

create unique index xmes_pk on xmes_t (xmesent,xmessite,xmesdocno,xmes001);

grant select on xmes_t to tiptop;
grant update on xmes_t to tiptop;
grant delete on xmes_t to tiptop;
grant insert on xmes_t to tiptop;

exit;
