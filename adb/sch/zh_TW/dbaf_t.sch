/* 
================================================================================
檔案代號:dbaf_t
檔案名稱:路線順序規劃資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbaf_t
(
dbafent       number(5)      ,/* 企業編號 */
dbaf001       varchar2(10)      ,/* 路線編號 */
dbaf002       varchar2(1)      ,/* 類型 */
dbaf003       varchar2(10)      ,/* 站點編號 */
dbaf004       number(5,0)      ,/* 路線順序 */
dbaf011       number(15,3)      ,/* 預估行駛時數 */
dbaf012       number(15,3)      ,/* 預估總時數 */
dbaf013       number(20,6)      ,/* 預估油費 */
dbaf014       number(20,6)      ,/* 預估過路費 */
dbaf015       number(20,6)      ,/* 預估總費用 */
dbafownid       varchar2(20)      ,/* 資料所有者 */
dbafowndp       varchar2(10)      ,/* 資料所屬部門 */
dbafcrtid       varchar2(20)      ,/* 資料建立者 */
dbafcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbafcrtdt       timestamp(0)      ,/* 資料創建日 */
dbafmodid       varchar2(20)      ,/* 資料修改者 */
dbafmoddt       timestamp(0)      ,/* 最近修改日 */
dbafstus       varchar2(10)      ,/* 狀態碼 */
dbafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbaf_t add constraint dbaf_pk primary key (dbafent,dbaf001,dbaf002,dbaf003) enable validate;

create unique index dbaf_pk on dbaf_t (dbafent,dbaf001,dbaf002,dbaf003);

grant select on dbaf_t to tiptop;
grant update on dbaf_t to tiptop;
grant delete on dbaf_t to tiptop;
grant insert on dbaf_t to tiptop;

exit;
