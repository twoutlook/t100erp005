/* 
================================================================================
檔案代號:mrdj_t
檔案名稱:資源維修工單報工單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mrdj_t
(
mrdjent       number(5)      ,/* 企業編號 */
mrdjsite       varchar2(10)      ,/* 營運據點 */
mrdjdocno       varchar2(20)      ,/* 報工單號 */
mrdjdocdt       date      ,/* 報工日期 */
mrdj001       varchar2(20)      ,/* 報工人員 */
mrdj002       varchar2(10)      ,/* 報工部門 */
mrdj003       varchar2(4000)      ,/* 備註 */
mrdjownid       varchar2(20)      ,/* 資料所有者 */
mrdjowndp       varchar2(10)      ,/* 資料所屬部門 */
mrdjcrtid       varchar2(20)      ,/* 資料建立者 */
mrdjcrtdp       varchar2(10)      ,/* 資料建立部門 */
mrdjcrtdt       timestamp(0)      ,/* 資料創建日 */
mrdjmodid       varchar2(20)      ,/* 資料修改者 */
mrdjmoddt       timestamp(0)      ,/* 最近修改日 */
mrdjcnfid       varchar2(20)      ,/* 資料確認者 */
mrdjcnfdt       timestamp(0)      ,/* 資料確認日 */
mrdjstus       varchar2(10)      ,/* 狀態碼 */
mrdjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrdj_t add constraint mrdj_pk primary key (mrdjent,mrdjdocno) enable validate;

create unique index mrdj_pk on mrdj_t (mrdjent,mrdjdocno);

grant select on mrdj_t to tiptop;
grant update on mrdj_t to tiptop;
grant delete on mrdj_t to tiptop;
grant insert on mrdj_t to tiptop;

exit;
