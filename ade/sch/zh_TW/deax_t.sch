/* 
================================================================================
檔案代號:deax_t
檔案名稱:保全對賬單頭
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deax_t
(
deaxent       number(5)      ,/* 企業編號 */
deaxsite       varchar2(10)      ,/* 營運據點 */
deaxunit       varchar2(10)      ,/* 應用組織 */
deaxdocdt       date      ,/* 單據日期 */
deaxdocno       varchar2(20)      ,/* 單據編號 */
deax001       varchar2(10)      ,/* 保全編號 */
deax002       varchar2(20)      ,/* 存繳單號 */
deax003       date      ,/* 存繳日期 */
deax004       varchar2(10)      ,/* 部門 */
deax005       varchar2(20)      ,/* 人員 */
deaxownid       varchar2(20)      ,/* 資料所有者 */
deaxowndp       varchar2(10)      ,/* 資料所屬部門 */
deaxcrtid       varchar2(20)      ,/* 資料建立者 */
deaxcrtdp       varchar2(10)      ,/* 資料建立部門 */
deaxcrtdt       timestamp(0)      ,/* 資料創建日 */
deaxmodid       varchar2(20)      ,/* 資料修改者 */
deaxmoddt       timestamp(0)      ,/* 最近修改日 */
deaxcnfid       varchar2(20)      ,/* 資料確認者 */
deaxcnfdt       timestamp(0)      ,/* 資料確認日 */
deaxstus       varchar2(10)      ,/* 狀態碼 */
deaxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deax_t add constraint deax_pk primary key (deaxent,deaxdocno) enable validate;

create unique index deax_pk on deax_t (deaxent,deaxdocno);

grant select on deax_t to tiptop;
grant update on deax_t to tiptop;
grant delete on deax_t to tiptop;
grant insert on deax_t to tiptop;

exit;
