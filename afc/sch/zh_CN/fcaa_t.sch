/* 
================================================================================
檔案代號:fcaa_t
檔案名稱:DMS公式參數檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fcaa_t
(
fcaaent       number(5)      ,/* 企業編號 */
fcaa001       varchar2(10)      ,/* 歷史資料乘百分比法-前期銷量基數 */
fcaa002       number(20,6)      ,/* 歷史資料乘百分比法-百分比 */
fcaa011       varchar2(10)      ,/* 移動平均法-前期銷量基數 */
fcaa012       number(5,0)      ,/* 移動平均法-移動期數N */
fcaa021       varchar2(10)      ,/* 加權移動平均法-前期銷量基數 */
fcaa022       number(5,0)      ,/* 加權移動平均法-移動期數N */
fcaa023       varchar2(255)      ,/* 加權移動平均法-權數 */
fcaa031       number(20,6)      ,/* 指數平滑法-平滑指數 */
fcaaownid       varchar2(20)      ,/* 資料所有者 */
fcaaowndp       varchar2(10)      ,/* 資料所屬部門 */
fcaacrtid       varchar2(20)      ,/* 資料建立者 */
fcaacrtdp       varchar2(10)      ,/* 資料建立部門 */
fcaacrtdt       timestamp(0)      ,/* 資料創建日 */
fcaamodid       varchar2(20)      ,/* 資料修改者 */
fcaamoddt       timestamp(0)      ,/* 最近修改日 */
fcaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fcaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fcaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fcaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fcaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fcaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fcaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fcaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fcaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fcaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fcaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fcaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fcaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fcaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fcaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fcaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fcaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fcaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fcaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fcaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fcaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fcaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fcaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fcaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fcaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fcaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fcaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fcaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fcaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fcaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fcaa_t add constraint fcaa_pk primary key (fcaaent) enable validate;

create unique index fcaa_pk on fcaa_t (fcaaent);

grant select on fcaa_t to tiptop;
grant update on fcaa_t to tiptop;
grant delete on fcaa_t to tiptop;
grant insert on fcaa_t to tiptop;

exit;
