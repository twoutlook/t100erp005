/* 
================================================================================
檔案代號:oofe_t
檔案名稱:常用備註檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oofe_t
(
oofeent       number(5)      ,/* 企業編號 */
oofestus       varchar2(10)      ,/* 狀態碼 */
oofe001       varchar2(10)      ,/* 備註類型 */
oofe002       varchar2(40)      ,/* 第一key值 */
oofe003       varchar2(40)      ,/* 第二key值 */
oofe004       varchar2(40)      ,/* 第三key值 */
oofe005       varchar2(40)      ,/* 第四key值 */
oofe006       varchar2(40)      ,/* 第五key值 */
oofe007       varchar2(4000)      ,/* 備註說明 */
oofe008       date      ,/* 失效日期 */
oofeownid       varchar2(20)      ,/* 資料所有者 */
oofeowndp       varchar2(10)      ,/* 資料所屬部門 */
oofecrtid       varchar2(20)      ,/* 資料建立者 */
oofecrtdp       varchar2(10)      ,/* 資料建立部門 */
oofecrtdt       timestamp(0)      ,/* 資料創建日 */
oofemodid       varchar2(20)      ,/* 資料修改者 */
oofemoddt       timestamp(0)      ,/* 最近修改日 */
oofeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofe_t add constraint oofe_pk primary key (oofeent,oofe001,oofe002,oofe003,oofe004,oofe005,oofe006) enable validate;

create unique index oofe_pk on oofe_t (oofeent,oofe001,oofe002,oofe003,oofe004,oofe005,oofe006);

grant select on oofe_t to tiptop;
grant update on oofe_t to tiptop;
grant delete on oofe_t to tiptop;
grant insert on oofe_t to tiptop;

exit;
