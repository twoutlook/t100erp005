/* 
================================================================================
檔案代號:oohj_t
檔案名稱:控制組營業渠道檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oohj_t
(
oohjent       number(5)      ,/* 企業編號 */
oohj001       varchar2(10)      ,/* 控制組編號 */
oohj002       varchar2(10)      ,/* 營業通路 */
oohj003       date      ,/* 生效日期 */
oohj004       date      ,/* 失效日期 */
oohjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oohjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oohjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oohjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oohjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oohjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oohjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oohjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oohjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oohjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oohjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oohjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oohjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oohjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oohjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oohjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oohjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oohjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oohjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oohjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oohjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oohjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oohjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oohjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oohjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oohjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oohjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oohjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oohjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oohjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oohj_t add constraint oohj_pk primary key (oohjent,oohj001,oohj002) enable validate;

create  index oohj_01 on oohj_t (oohj003);
create  index oohj_02 on oohj_t (oohj004);
create unique index oohj_pk on oohj_t (oohjent,oohj001,oohj002);

grant select on oohj_t to tiptop;
grant update on oohj_t to tiptop;
grant delete on oohj_t to tiptop;
grant insert on oohj_t to tiptop;

exit;
