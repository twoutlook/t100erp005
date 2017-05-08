/* 
================================================================================
檔案代號:fmdd_t
檔案名稱:解除抵押質押單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmdd_t
(
fmddent       number(5)      ,/* 企業編號 */
fmdddocno       varchar2(20)      ,/* 解除質押單號 */
fmddsite       varchar2(10)      ,/* 融資組織 */
fmddcomp       varchar2(10)      ,/* 歸屬法人 */
fmdddocdt       date      ,/* 日期 */
fmddownid       varchar2(20)      ,/* 資料所屬者 */
fmddowndp       varchar2(10)      ,/* 資料所屬部門 */
fmddcrtid       varchar2(20)      ,/* 資料建立者 */
fmddcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmddcrtdt       timestamp(0)      ,/* 資料創建日 */
fmddmodid       varchar2(20)      ,/* 資料修改者 */
fmddmoddt       timestamp(0)      ,/* 最近修改日 */
fmddcnfid       varchar2(20)      ,/* 資料確認者 */
fmddcnfdt       timestamp(0)      ,/* 資料確認日 */
fmddstus       varchar2(10)      ,/* 狀態碼 */
fmddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmdd_t add constraint fmdd_pk primary key (fmddent,fmdddocno) enable validate;

create unique index fmdd_pk on fmdd_t (fmddent,fmdddocno);

grant select on fmdd_t to tiptop;
grant update on fmdd_t to tiptop;
grant delete on fmdd_t to tiptop;
grant insert on fmdd_t to tiptop;

exit;
