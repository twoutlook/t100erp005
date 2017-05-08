/* 
================================================================================
檔案代號:inas_t
檔案名稱:庫存需求等候明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inas_t
(
inasent       number(5)      ,/* 企業編號 */
inassite       varchar2(10)      ,/* 營運據點 */
inas001       varchar2(20)      ,/* 單據編號 */
inas002       number(10,0)      ,/* 單據項次 */
inas003       number(10,0)      ,/* 單據項序 */
inas004       number(10,0)      ,/* 單據分批序 */
inas005       timestamp(0)      ,/* 原始排隊日期時間 */
inas006       timestamp(0)      ,/* 調整後排隊日期時間 */
inas007       varchar2(20)      ,/* 單據性質 */
inas008       varchar2(20)      ,/* 作業編號 */
inas009       varchar2(40)      ,/* 料件編號 */
inas010       varchar2(256)      ,/* 產品特徵 */
inas011       number(20,6)      ,/* 排隊數量 */
inas012       number(20,6)      ,/* 基礎單位排隊數量 */
inas013       varchar2(10)      ,/* 交易單位 */
inas014       number(20,6)      ,/* 原始需求數量 */
inas015       date      ,/* 需求日期 */
inas016       varchar2(20)      ,/* 負責人員 */
inas017       varchar2(10)      ,/* 負責部門 */
inasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inasud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inas_t add constraint inas_pk primary key (inasent,inassite,inas001,inas002,inas003,inas004) enable validate;

create unique index inas_pk on inas_t (inasent,inassite,inas001,inas002,inas003,inas004);

grant select on inas_t to tiptop;
grant update on inas_t to tiptop;
grant delete on inas_t to tiptop;
grant insert on inas_t to tiptop;

exit;
