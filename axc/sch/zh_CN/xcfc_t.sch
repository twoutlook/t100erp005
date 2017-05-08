/* 
================================================================================
檔案代號:xcfc_t
檔案名稱:LCM计算基础辅档-货龄和呆滞率维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfc_t
(
xcfcent       number(5)      ,/* 企业编号 */
xcfccomp       varchar2(10)      ,/* 法人组织 */
xcfcld       varchar2(5)      ,/* 账套 */
xcfc001       number(5,0)      ,/* 年度 */
xcfc002       number(5,0)      ,/* 期别 */
xcfcseq       number(10,0)      ,/* 项次 */
xcfc010       number(15,3)      ,/* 起始天数 */
xcfc011       number(15,3)      ,/* 截至天数 */
xcfc012       number(20,6)      ,/* 呆滞比率 */
xcfcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcfc013       varchar2(10)      /* 材料分类 */
);
alter table xcfc_t add constraint xcfc_pk primary key (xcfcent,xcfcld,xcfc001,xcfc002,xcfcseq) enable validate;

create unique index xcfc_pk on xcfc_t (xcfcent,xcfcld,xcfc001,xcfc002,xcfcseq);

grant select on xcfc_t to tiptop;
grant update on xcfc_t to tiptop;
grant delete on xcfc_t to tiptop;
grant insert on xcfc_t to tiptop;

exit;
