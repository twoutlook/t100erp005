/* 
================================================================================
檔案代號:bmja_t
檔案名稱:ECR模板維護單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bmja_t
(
bmjaent       number(5)      ,/* 企業代碼 */
bmjaownid       varchar2(20)      ,/* 資料所有者 */
bmjaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmjacrtid       varchar2(20)      ,/* 資料建立者 */
bmjacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmjacrtdt       timestamp(0)      ,/* 資料創建日 */
bmjamodid       varchar2(20)      ,/* 資料修改者 */
bmjamoddt       timestamp(0)      ,/* 最近修改日 */
bmjastus       varchar2(10)      ,/* 狀態碼 */
bmjasite       varchar2(10)      ,/* 營運據點 */
bmja001       varchar2(10)      ,/* 模板編號 */
bmjaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmjaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmjaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmjaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmjaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmjaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmjaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmjaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmjaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmjaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmjaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmjaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmjaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmjaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmjaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmjaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmjaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmjaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmjaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmjaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmjaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmjaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmjaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmjaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmjaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmjaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmjaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmjaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmjaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmjaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmja_t add constraint bmja_pk primary key (bmjaent,bmja001) enable validate;

create unique index bmja_pk on bmja_t (bmjaent,bmja001);

grant select on bmja_t to tiptop;
grant update on bmja_t to tiptop;
grant delete on bmja_t to tiptop;
grant insert on bmja_t to tiptop;

exit;
