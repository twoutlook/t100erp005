/* 
================================================================================
檔案代號:sfeb_t
檔案名稱:完工入庫申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table sfeb_t
(
sfebent       number(5)      ,/* 企業編號 */
sfebsite       varchar2(10)      ,/* 營運據點 */
sfebdocno       varchar2(20)      ,/* 完工入庫單號 */
sfebseq       number(10,0)      ,/* 項次 */
sfeb001       varchar2(20)      ,/* 工單單號 */
sfeb002       varchar2(1)      ,/* FQC */
sfeb003       varchar2(10)      ,/* 入庫類型 */
sfeb004       varchar2(40)      ,/* 料件編號 */
sfeb005       varchar2(256)      ,/* 特徵 */
sfeb006       varchar2(40)      ,/* 包裝容器 */
sfeb007       varchar2(10)      ,/* 單位 */
sfeb008       number(20,6)      ,/* 申請數量 */
sfeb009       number(20,6)      ,/* 實際數量 */
sfeb010       varchar2(10)      ,/* 參考單位 */
sfeb011       number(20,6)      ,/* 申請參考數量 */
sfeb012       number(20,6)      ,/* 實際參考數量 */
sfeb013       varchar2(10)      ,/* 指定庫位 */
sfeb014       varchar2(10)      ,/* 指定儲位 */
sfeb015       varchar2(30)      ,/* 指定批號 */
sfeb016       varchar2(30)      ,/* 庫存管理特徵 */
sfeb017       varchar2(20)      ,/* 專案代號 */
sfeb018       varchar2(30)      ,/* WBS */
sfeb019       varchar2(30)      ,/* 活動代號 */
sfeb020       varchar2(10)      ,/* 理由碼 */
sfeb021       date      ,/* 庫存有效日期 */
sfeb022       varchar2(4000)      ,/* 庫存備註 */
sfeb023       varchar2(40)      ,/* 生產料號 */
sfeb024       varchar2(30)      ,/* 生產料號BOM特性 */
sfeb025       varchar2(256)      ,/* 生產料號特徵 */
sfeb026       number(10,0)      ,/* RUN CARD */
sfeb027       number(20,6)      ,/* 檢驗合格量 */
sfebud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfebud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfebud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfebud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfebud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfebud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfebud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfebud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfebud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfebud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfebud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfebud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfebud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfebud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfebud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfebud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfebud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfebud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfebud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfebud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfebud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfebud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfebud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfebud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfebud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfebud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfebud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfebud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfebud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfebud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfeb_t add constraint sfeb_pk primary key (sfebent,sfebdocno,sfebseq) enable validate;

create unique index sfeb_pk on sfeb_t (sfebent,sfebdocno,sfebseq);

grant select on sfeb_t to tiptop;
grant update on sfeb_t to tiptop;
grant delete on sfeb_t to tiptop;
grant insert on sfeb_t to tiptop;

exit;
