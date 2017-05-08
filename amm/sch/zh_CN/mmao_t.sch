/* 
================================================================================
檔案代號:mmao_t
檔案名稱:效期延長規則設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmao_t
(
mmaoent       number(5)      ,/* 企業編號 */
mmao001       varchar2(10)      ,/* 卡種編號 */
mmao002       number(10,0)      ,/* 組別 */
mmao003       varchar2(10)      ,/* 效期延長規則 */
mmao004       number(20,6)      ,/* 規則下限 */
mmaostus       varchar2(10)      ,/* 有效 */
mmaoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmaoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmaoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmaoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmaoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmaoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmaoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmaoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmaoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmaoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmaoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmaoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmaoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmaoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmaoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmaoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmaoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmaoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmaoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmaoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmaoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmaoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmaoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmaoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmaoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmaoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmaoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmaoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmaoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmaoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmao_t add constraint mmao_pk primary key (mmaoent,mmao001,mmao002,mmao003) enable validate;

create unique index mmao_pk on mmao_t (mmaoent,mmao001,mmao002,mmao003);

grant select on mmao_t to tiptop;
grant update on mmao_t to tiptop;
grant delete on mmao_t to tiptop;
grant insert on mmao_t to tiptop;

exit;
