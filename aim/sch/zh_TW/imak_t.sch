/* 
================================================================================
檔案代號:imak_t
檔案名稱:料件特征档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imak_t
(
imakent       number(5)      ,/* 企业编号 */
imak001       varchar2(40)      ,/* 料件编号 */
imak002       varchar2(10)      ,/* 特征类型 */
imak003       varchar2(30)      ,/* 特征值 */
imakud001       varchar2(40)      ,/* 自定义栏位(文字)001 */
imakud002       varchar2(40)      ,/* 自定义栏位(文字)002 */
imakud003       varchar2(40)      ,/* 自定义栏位(文字)003 */
imakud004       varchar2(40)      ,/* 自定义栏位(文字)004 */
imakud005       varchar2(40)      ,/* 自定义栏位(文字)005 */
imakud006       varchar2(40)      ,/* 自定义栏位(文字)006 */
imakud007       varchar2(40)      ,/* 自定义栏位(文字)007 */
imakud008       varchar2(40)      ,/* 自定义栏位(文字)008 */
imakud009       varchar2(40)      ,/* 自定义栏位(文字)009 */
imakud010       varchar2(40)      ,/* 自定义栏位(文字)010 */
imakud011       number(20,6)      ,/* 自定义栏位(数字)011 */
imakud012       number(20,6)      ,/* 自定义栏位(数字)012 */
imakud013       number(20,6)      ,/* 自定义栏位(数字)013 */
imakud014       number(20,6)      ,/* 自定义栏位(数字)014 */
imakud015       number(20,6)      ,/* 自定义栏位(数字)015 */
imakud016       number(20,6)      ,/* 自定义栏位(数字)016 */
imakud017       number(20,6)      ,/* 自定义栏位(数字)017 */
imakud018       number(20,6)      ,/* 自定义栏位(数字)018 */
imakud019       number(20,6)      ,/* 自定义栏位(数字)019 */
imakud020       number(20,6)      ,/* 自定义栏位(数字)020 */
imakud021       timestamp(0)      ,/* 自定义栏位(日期时间)021 */
imakud022       timestamp(0)      ,/* 自定义栏位(日期时间)022 */
imakud023       timestamp(0)      ,/* 自定义栏位(日期时间)023 */
imakud024       timestamp(0)      ,/* 自定义栏位(日期时间)024 */
imakud025       timestamp(0)      ,/* 自定义栏位(日期时间)025 */
imakud026       timestamp(0)      ,/* 自定义栏位(日期时间)026 */
imakud027       timestamp(0)      ,/* 自定义栏位(日期时间)027 */
imakud028       timestamp(0)      ,/* 自定义栏位(日期时间)028 */
imakud029       timestamp(0)      ,/* 自定义栏位(日期时间)029 */
imakud030       timestamp(0)      /* 自定义栏位(日期时间)030 */
);
alter table imak_t add constraint imak_pk primary key (imakent,imak001,imak002) enable validate;

create unique index imak_pk on imak_t (imakent,imak001,imak002);

grant select on imak_t to tiptop;
grant update on imak_t to tiptop;
grant delete on imak_t to tiptop;
grant insert on imak_t to tiptop;

exit;
