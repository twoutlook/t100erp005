/* 
================================================================================
檔案代號:xmfr_t
檔案名稱:客訴單調查結果檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmfr_t
(
xmfrent       number(5)      ,/* 企業編號 */
xmfrsite       varchar2(10)      ,/* 營運據點 */
xmfrdocno       varchar2(20)      ,/* 客訴單號 */
xmfrseq       number(10,0)      ,/* 項次 */
xmfr001       varchar2(500)      ,/* 調查結果 */
xmfr002       varchar2(20)      ,/* 主辦人員 */
xmfr003       varchar2(10)      ,/* 責任單位 */
xmfrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmfrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmfrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmfrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmfrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmfrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmfrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmfrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmfrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmfrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmfrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmfrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmfrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmfrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmfrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmfrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmfrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmfrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmfrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmfrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmfrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmfrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmfrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmfrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmfrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmfrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmfrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmfrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmfrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmfrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmfr_t add constraint xmfr_pk primary key (xmfrent,xmfrdocno,xmfrseq) enable validate;

create unique index xmfr_pk on xmfr_t (xmfrent,xmfrdocno,xmfrseq);

grant select on xmfr_t to tiptop;
grant update on xmfr_t to tiptop;
grant delete on xmfr_t to tiptop;
grant insert on xmfr_t to tiptop;

exit;
