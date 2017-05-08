/* 
================================================================================
檔案代號:stag_t
檔案名稱:自營合約模板主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table stag_t
(
stagent       number(5)      ,/* 企業編號 */
stag001       varchar2(10)      ,/* 模板編號 */
stag002       varchar2(10)      ,/* 經營方式 */
stag003       varchar2(10)      ,/* 收付款方式 */
stag004       varchar2(10)      ,/* 結算方式 */
stag005       varchar2(10)      ,/* 結算類型 */
stag006       varchar2(10)      ,/* 幣別 */
stag007       varchar2(10)      ,/* 稅目 */
stag008       varchar2(10)      ,/* 指定組織 */
stagunit       varchar2(10)      ,/* 應用組織 */
stagownid       varchar2(20)      ,/* 資料所有者 */
stagowndp       varchar2(10)      ,/* 資料所屬部門 */
stagcrtid       varchar2(20)      ,/* 資料建立者 */
stagcrtdp       varchar2(10)      ,/* 資料建立部門 */
stagcrtdt       timestamp(0)      ,/* 資料創建日 */
stagmodid       varchar2(20)      ,/* 資料修改者 */
stagmoddt       timestamp(0)      ,/* 最近修改日 */
stagstus       varchar2(10)      ,/* 狀態碼 */
stagcnfid       varchar2(20)      ,/* 資料確認者 */
stagcnfdt       timestamp(0)      ,/* 資料確認日 */
stagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stag_t add constraint stag_pk primary key (stagent,stag001) enable validate;

create unique index stag_pk on stag_t (stagent,stag001);

grant select on stag_t to tiptop;
grant update on stag_t to tiptop;
grant delete on stag_t to tiptop;
grant insert on stag_t to tiptop;

exit;
