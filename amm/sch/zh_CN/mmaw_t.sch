/* 
================================================================================
檔案代號:mmaw_t
檔案名稱:會員卡發行單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmaw_t
(
mmawent       number(5)      ,/* 企業編號 */
mmawsite       varchar2(10)      ,/* 營運據點 */
mmawunit       varchar2(10)      ,/* 應用組織 */
mmawdocno       varchar2(20)      ,/* 單據編號 */
mmawdocdt       date      ,/* 單據日期 */
mmaw001       varchar2(20)      ,/* 空白卡雜發單號 */
mmawstus       varchar2(10)      ,/* 狀態碼 */
mmawownid       varchar2(20)      ,/* 資料所有者 */
mmawowndp       varchar2(10)      ,/* 資料所屬部門 */
mmawcrtid       varchar2(20)      ,/* 資料建立者 */
mmawcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmawcrtdt       timestamp(0)      ,/* 資料創建日 */
mmawmodid       varchar2(20)      ,/* 資料修改者 */
mmawmoddt       timestamp(0)      ,/* 最近修改日 */
mmawcnfid       varchar2(20)      ,/* 資料確認者 */
mmawcnfdt       timestamp(0)      ,/* 資料確認日 */
mmawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmawud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmaw_t add constraint mmaw_pk primary key (mmawent,mmawdocno) enable validate;

create unique index mmaw_pk on mmaw_t (mmawent,mmawdocno);

grant select on mmaw_t to tiptop;
grant update on mmaw_t to tiptop;
grant delete on mmaw_t to tiptop;
grant insert on mmaw_t to tiptop;

exit;
