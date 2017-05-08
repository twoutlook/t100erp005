/* 
================================================================================
檔案代號:pmei_t
檔案名稱:採購變更關聯單據明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmei_t
(
pmeient       number(5)      ,/* 企業編號 */
pmeisite       varchar2(10)      ,/* 營運據點 */
pmeidocno       varchar2(20)      ,/* 採購變更單號 */
pmeiseq       number(10,0)      ,/* 採購項次 */
pmeiseq1       number(10,0)      ,/* 項序 */
pmei001       varchar2(40)      ,/* 料件編號 */
pmei002       varchar2(256)      ,/* 產品特徵 */
pmei003       varchar2(20)      ,/* 來源單號 */
pmei004       number(10,0)      ,/* 來源項次 */
pmei005       number(10,0)      ,/* 來源項序 */
pmei006       number(10,0)      ,/* 來源分批序 */
pmei007       varchar2(40)      ,/* 來源料號 */
pmei008       varchar2(256)      ,/* 來源產品特徵 */
pmei009       varchar2(10)      ,/* 來源作業編號 */
pmei010       varchar2(10)      ,/* 來源作業序 */
pmei011       varchar2(30)      ,/* 來源BOM特性 */
pmei012       varchar2(10)      ,/* 來源生產控制組 */
pmei021       number(10,0)      ,/* 沖銷順序 */
pmei022       varchar2(10)      ,/* 需求單位 */
pmei023       number(20,6)      ,/* 需求數量 */
pmei024       number(20,6)      ,/* 折合採購量 */
pmei025       number(20,6)      ,/* 已收貨量 */
pmei026       number(20,6)      ,/* 已入庫量 */
pmei900       number(10,0)      ,/* 變更序 */
pmei901       varchar2(1)      ,/* 變更類型 */
pmeiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmeiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmeiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmeiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmeiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmeiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmeiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmeiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmeiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmeiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmeiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmeiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmeiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmeiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmeiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmeiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmeiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmeiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmeiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmeiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmeiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmeiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmeiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmeiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmeiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmeiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmeiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmeiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmeiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmeiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmei_t add constraint pmei_pk primary key (pmeient,pmeidocno,pmeiseq,pmeiseq1,pmei900) enable validate;

create unique index pmei_pk on pmei_t (pmeient,pmeidocno,pmeiseq,pmeiseq1,pmei900);

grant select on pmei_t to tiptop;
grant update on pmei_t to tiptop;
grant delete on pmei_t to tiptop;
grant insert on pmei_t to tiptop;

exit;
