/* 
================================================================================
檔案代號:xcfj_t
檔案名稱:LCM存貨貨齡計算明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcfj_t
(
xcfjent       number(5)      ,/* 企業編號 */
xcfjcomp       varchar2(10)      ,/* 法人組織 */
xcfjld       varchar2(5)      ,/* 帳套 */
xcfj001       varchar2(30)      ,/* 成本域 */
xcfj002       varchar2(10)      ,/* 成本計算類型 */
xcfj003       number(5,0)      ,/* 年度 */
xcfj004       number(5,0)      ,/* 期別 */
xcfj005       varchar2(40)      ,/* 料件 */
xcfj006       varchar2(256)      ,/* 特性 */
xcfj007       varchar2(30)      ,/* 批號 */
xcfj008       date      ,/* 異動日期 */
xcfj009       number(20,6)      ,/* 數量 */
xcfjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcfj_t add constraint xcfj_pk primary key (xcfjent,xcfjld,xcfj001,xcfj002,xcfj003,xcfj004,xcfj005,xcfj006,xcfj007,xcfj008) enable validate;

create unique index xcfj_pk on xcfj_t (xcfjent,xcfjld,xcfj001,xcfj002,xcfj003,xcfj004,xcfj005,xcfj006,xcfj007,xcfj008);

grant select on xcfj_t to tiptop;
grant update on xcfj_t to tiptop;
grant delete on xcfj_t to tiptop;
grant insert on xcfj_t to tiptop;

exit;
