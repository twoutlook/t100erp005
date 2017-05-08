/* 
================================================================================
檔案代號:faai_t
檔案名稱:固定資產標籤檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faai_t
(
faaient       number(5)      ,/* 企業編號 */
faai000       varchar2(10)      ,/* 生成批號 */
faai001       varchar2(10)      ,/* 卡片編號 */
faai002       varchar2(20)      ,/* 財產編號 */
faai003       varchar2(20)      ,/* 附號 */
faaiseq       number(10,0)      ,/* 項次 */
faai004       varchar2(10)      ,/* 財簽條碼 */
faai005       varchar2(20)      ,/* S/N號碼 */
faai006       varchar2(10)      ,/* 單位 */
faai007       number(20,6)      ,/* 數量 */
faai008       number(20,6)      ,/* 在外數量 */
faai009       varchar2(10)      ,/* 供應廠商 */
faai010       varchar2(10)      ,/* 製造廠商 */
faai011       varchar2(10)      ,/* 產地 */
faai012       varchar2(500)      ,/* 名稱 */
faai013       varchar2(500)      ,/* 規格型號 */
faai014       date      ,/* 取得日期 */
faai015       varchar2(20)      ,/* 保管人員 */
faai016       varchar2(10)      ,/* 保管部門 */
faai017       varchar2(10)      ,/* 存放位置 */
faai018       varchar2(10)      ,/* 存放組織 */
faai019       varchar2(20)      ,/* 負責人員 */
faai020       varchar2(10)      ,/* 管理組織 */
faai021       varchar2(10)      ,/* 核算組織 */
faai022       varchar2(10)      ,/* 歸屬法人 */
faai023       number(10)      ,/* 標籤狀態 */
faaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faai_t add constraint faai_pk primary key (faaient,faai000,faai001,faai002,faai003,faaiseq) enable validate;

create unique index faai_pk on faai_t (faaient,faai000,faai001,faai002,faai003,faaiseq);

grant select on faai_t to tiptop;
grant update on faai_t to tiptop;
grant delete on faai_t to tiptop;
grant insert on faai_t to tiptop;

exit;
