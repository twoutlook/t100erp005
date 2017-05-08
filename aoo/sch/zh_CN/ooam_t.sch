/* 
================================================================================
檔案代號:ooam_t
檔案名稱:日匯率單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooam_t
(
ooament       number(5)      ,/* 企業編號 */
ooam001       varchar2(5)      ,/* 匯率參照表號 */
ooam003       varchar2(10)      ,/* 基礎幣別 */
ooam004       date      ,/* 日期 */
ooam005       number(20,6)      ,/* 交易貨幣批量 */
ooam007       varchar2(1)      ,/* 自動預設交叉匯率 */
ooamownid       varchar2(20)      ,/* 資料所有者 */
ooamowndp       varchar2(10)      ,/* 資料所屬部門 */
ooamcrtid       varchar2(20)      ,/* 資料建立者 */
ooamcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooamcrtdt       timestamp(0)      ,/* 資料創建日 */
ooammodid       varchar2(20)      ,/* 資料修改者 */
ooammoddt       timestamp(0)      ,/* 最近修改日 */
ooamstus       varchar2(10)      ,/* 狀態碼 */
ooamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooam_t add constraint ooam_pk primary key (ooament,ooam001,ooam003,ooam004) enable validate;

create unique index ooam_pk on ooam_t (ooament,ooam001,ooam003,ooam004);

grant select on ooam_t to tiptop;
grant update on ooam_t to tiptop;
grant delete on ooam_t to tiptop;
grant insert on ooam_t to tiptop;

exit;
