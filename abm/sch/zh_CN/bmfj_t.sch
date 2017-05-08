/* 
================================================================================
檔案代號:bmfj_t
檔案名稱:ECN特徵限定用料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfj_t
(
bmfjent       number(5)      ,/* 企業編號 */
bmfjsite       varchar2(10)      ,/* 營運據點 */
bmfjdocno       varchar2(20)      ,/* ECN單號 */
bmfj002       number(10,0)      ,/* ECN項次 */
bmfj003       varchar2(30)      ,/* 限定特徵 */
bmfj004       number(10,0)      ,/* 項次 */
bmfj005       varchar2(30)      ,/* 特徴起始值 */
bmfj006       varchar2(30)      ,/* 特徵終止值 */
bmfjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfj_t add constraint bmfj_pk primary key (bmfjent,bmfjsite,bmfjdocno,bmfj002,bmfj003,bmfj004) enable validate;

create unique index bmfj_pk on bmfj_t (bmfjent,bmfjsite,bmfjdocno,bmfj002,bmfj003,bmfj004);

grant select on bmfj_t to tiptop;
grant update on bmfj_t to tiptop;
grant delete on bmfj_t to tiptop;
grant insert on bmfj_t to tiptop;

exit;
