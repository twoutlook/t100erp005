/* 
================================================================================
檔案代號:xcff_t
檔案名稱:LCM料件销售毛利和费率分类设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcff_t
(
xcffent       number(5)      ,/* 企业编号 */
xcffcomp       varchar2(10)      ,/* 法人组织 */
xcff001       number(5,0)      ,/* 年度 */
xcff002       number(5,0)      ,/* 期别 */
xcff003       number(5)      ,/* 料件分类来源 */
xcff004       varchar2(40)      ,/* 分类码 */
xcff005       number(20,6)      ,/* 销售毛利率 */
xcff006       number(20,6)      ,/* 销售费用率 */
xcffud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcffud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcffud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcffud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcffud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcffud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcffud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcffud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcffud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcffud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcffud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcffud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcffud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcffud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcffud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcffud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcffud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcffud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcffud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcffud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcffud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcffud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcffud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcffud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcffud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcffud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcffud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcffud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcffud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcffud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xcffld       varchar2(5)      /* 账套 */
);
alter table xcff_t add constraint xcff_pk primary key (xcffent,xcffcomp,xcff001,xcff002,xcff003,xcff004,xcffld) enable validate;

create unique index xcff_pk on xcff_t (xcffent,xcffcomp,xcff001,xcff002,xcff003,xcff004,xcffld);

grant select on xcff_t to tiptop;
grant update on xcff_t to tiptop;
grant delete on xcff_t to tiptop;
grant insert on xcff_t to tiptop;

exit;
