/* 
================================================================================
檔案代號:fabi_t
檔案名稱:固定資產異動標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fabi_t
(
fabient       number(5)      ,/* 企業編號 */
fabild       varchar2(5)      ,/* 帳套 */
fabicomp       varchar2(10)      ,/* 法人 */
fabisite       varchar2(10)      ,/* 資產中心 */
fabidocno       varchar2(20)      ,/* 單據編號 */
fabiseq       number(10,0)      ,/* 項次 */
fabiseq1       number(10,0)      ,/* 項次1 */
fabi000       number(10)      ,/* 單據性質 */
fabi001       varchar2(10)      ,/* 卡片編號 */
fabi002       varchar2(20)      ,/* 財產編號 */
fabi003       varchar2(20)      ,/* 附號 */
fabi004       varchar2(10)      ,/* 標籤條碼 */
fabi005       varchar2(10)      ,/* S/N號碼 */
fabi006       varchar2(10)      ,/* 單位 */
fabi007       number(20,6)      ,/* 數量 */
fabi008       number(20,6)      ,/* 在外數量 */
fabi009       varchar2(10)      ,/* 供應廠商 */
fabi010       varchar2(10)      ,/* 製造廠商 */
fabi011       varchar2(10)      ,/* 產地 */
fabi012       varchar2(500)      ,/* 名稱 */
fabi013       varchar2(500)      ,/* 規格型號 */
fabi014       date      ,/* 取得時間 */
fabi015       varchar2(20)      ,/* 保管人員 */
fabi016       varchar2(10)      ,/* 保管部門 */
fabi017       varchar2(10)      ,/* 存放位置 */
fabi018       varchar2(10)      ,/* 存放組織 */
fabi019       varchar2(20)      ,/* 負責人員 */
fabi020       varchar2(10)      ,/* 管理組織 */
fabi021       varchar2(10)      ,/* 核算組織 */
fabi022       varchar2(10)      ,/* 附屬法人 */
fabiownid       varchar2(20)      ,/* 資料所有者 */
fabiowndp       varchar2(10)      ,/* 資料所屬部門 */
fabicrtid       varchar2(20)      ,/* 資料建立者 */
fabicrtdp       varchar2(10)      ,/* 資料建立部門 */
fabicrtdt       timestamp(0)      ,/* 資料創建日 */
fabimodid       varchar2(20)      ,/* 資料修改者 */
fabimoddt       timestamp(0)      ,/* 最近修改日 */
fabicnfid       varchar2(20)      ,/* 資料確認者 */
fabicnfdt       timestamp(0)      ,/* 資料確認日 */
fabipstid       varchar2(20)      ,/* 資料過帳者 */
fabipstdt       timestamp(0)      ,/* 資料過帳日 */
fabistus       varchar2(10)      ,/* 狀態碼 */
fabiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabi_t add constraint fabi_pk primary key (fabient,fabidocno,fabiseq,fabiseq1,fabi000) enable validate;

create unique index fabi_pk on fabi_t (fabient,fabidocno,fabiseq,fabiseq1,fabi000);

grant select on fabi_t to tiptop;
grant update on fabi_t to tiptop;
grant delete on fabi_t to tiptop;
grant insert on fabi_t to tiptop;

exit;
