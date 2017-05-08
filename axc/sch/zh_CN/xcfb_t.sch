/* 
================================================================================
檔案代號:xcfb_t
檔案名稱:LCM计算基础辅档-材料类型单价和呆滞率维护档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcfb_t
(
xcfbent       number(5)      ,/* 企业编号 */
xcfbcomp       varchar2(10)      ,/* 法人组织 */
xcfbld       varchar2(5)      ,/* 账套 */
xcfb001       number(5,0)      ,/* 年度 */
xcfb002       number(5,0)      ,/* 期别 */
xcfbseq       number(10,0)      ,/* 项次 */
xcfb010       varchar2(10)      ,/* 材料分类 */
xcfb011       varchar2(10)      ,/* 币种 */
xcfb012       number(20,6)      ,/* 单价(起) */
xcfb013       number(20,6)      ,/* 呆滞比率 */
xcfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcfbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcfb014       number(20,6)      /* 单价(讫) */
);
alter table xcfb_t add constraint xcfb_pk primary key (xcfbent,xcfbld,xcfb001,xcfb002,xcfbseq) enable validate;

create unique index xcfb_pk on xcfb_t (xcfbent,xcfbld,xcfb001,xcfb002,xcfbseq);

grant select on xcfb_t to tiptop;
grant update on xcfb_t to tiptop;
grant delete on xcfb_t to tiptop;
grant insert on xcfb_t to tiptop;

exit;
